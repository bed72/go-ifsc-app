// import 'package:flutter/material.dart';
// import 'package:go_ifsc/app/app_bloc.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:go_ifsc/app/core/models/message_model.dart';
// import 'package:go_ifsc/app/core/services/shared_local_storage_service.dart';

// class FcmService {
//   final FirebaseMessaging _fcm = FirebaseMessaging();
//   final appBloc = Modular.get<AppBloc>();

//   FcmService._();

//   static final FcmService fcm = FcmService._();

//   Future _onLaunch(Map<String, dynamic> message) async => {
//         print('\n\nonLaunch: $message\n\n'),
//       };

//   Future _onResume(Map<String, dynamic> message) async => {
//         print('\n\nonResume: $message\n\n'),
//       };

//   void configure() async {
//     _fcm.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         print('\n\nonMessage: $message\n\n');
//         _setMessageDb(message);
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         print('\n\nonLaunch: $message\n\n');
//         await _onLaunch(message);
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print('\n\nonResume: $message\n\n');
//         await _onResume(message);
//       },
//     );
//     _permissions();
//     _iosSettings();
//   }

//   Future _permissions() async {
//     _fcm.requestNotificationPermissions(
//       IosNotificationSettings(
//         sound: true,
//         badge: true,
//         alert: true,
//         provisional: true,
//       ),
//     );
//   }

//   Future _iosSettings() async {
//     _fcm.onIosSettingsRegistered.listen(
//       (IosNotificationSettings settings) {
//         print('\n\nConfigurações Registradas: $settings\n\n');
//       },
//     );
//   }

//   // Setando messagem em DB
//   void _setMessageDb(Map<String, dynamic> message) async {
//     //print('\n\n MESSAGE: \n${message} \n\n');
//     final notification = message['notification'];
//     final data = message['data'];

//     final String title = notification['title'];
//     final String body = notification['body'];
//     final String onTitle = data['onTitle'];
//     final String onMessage = data['onMessage'];

//     MessageModel model = MessageModel(
//       title: title,
//       body: body,
//       onTitle: onTitle,
//       onMessage: onMessage,
//     );

//     appBloc.addMessage(model);
//   }

//   setTokenNotification() {
//     _fcm.getToken().then(
//       (String token) async {
//         assert(token != null);
//         print('\n\nToken Firebase: $token \n\n');
//         // Setando token do firebase
//         changeToken(token);
//       },
//     );
//   }

//   // Metodo para setar token do firebase
//   Future changeToken(String token) async {
//     await SharedLocalStorageService.localShared.put('tokenFirebase', token);
//   }

//   // verifica rota
//   void changeRoute() {
//     SharedLocalStorageService.localShared.get('sessionToken').then(
//           (value) => {
//             value == null
//                 ? Modular.to.pushReplacementNamed('/login')
//                 : Modular.to.pushReplacementNamed('/home'),
//           },
//         );
//   }
// }
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppPushs extends StatefulWidget {
  AppPushs({
    @required this.child,
  });

  final Widget child;

  @override
  _AppPushsState createState() => _AppPushsState();
}

class _AppPushsState extends State<AppPushs> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  initState() {
    super.initState();
    _initFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  _initFirebaseMessaging() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('AppPushs onMessage : $message');
        return;
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) {
        print('AppPushs onResume : $message');
        return;
      },
      onLaunch: (Map<String, dynamic> message) {
        print('AppPushs onLaunch : $message');
        return;
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  // TOP-LEVEL or STATIC function to handle background messages
  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    print('AppPushs myBackgroundMessageHandler : $message');
    return Future<void>.value();
  }
}
