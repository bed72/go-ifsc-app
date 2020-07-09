import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/app_bloc.dart';
import 'package:go_ifsc/app/core/models/message_model.dart';
import 'package:go_ifsc/app/core/services/shared_local_storage_service.dart';

class AppPushs extends StatefulWidget {
  AppPushs({
    @required this.child,
  });

  final Widget child;

  @override
  _AppPushsState createState() => _AppPushsState();
}

class _AppPushsState extends State<AppPushs> {
  final appBloc = Modular.get<AppBloc>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  initState() {
    super.initState();
    _initFirebaseMessaging();
    _setTokenFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  _initFirebaseMessaging() {
    print('\nCheck Message: OK \n');
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('\n\nAppPushs onMessage : $message\n\n');
        _setMessageDb(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('\n\nAppPushs onResume : $message\n\n');
        _setMessageDb(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('\n\nAppPushs onLaunch : $message\n\n');
        _setMessageDb(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true,
      ),
    );
  }

  Future _setTokenFirebase() async {
    _firebaseMessaging.getToken().then(
      (String token) async {
        assert(token != null);
        print('\n\nToken Firebase: $token \n\n');
        await _changeToken(token);
      },
    );
  }

  // Metodo para setar token do firebase
  Future _changeToken(String token) async {
    await SharedLocalStorageService.localShared.put('tokenFirebase', token);
  }

  // Setando messagem em DB
  void _setMessageDb(Map<String, dynamic> message) async {
    print('\n\n MESSAGE: \n${message.values} \n\n');
    final notification = message['notification'];
    final data = message['data'];

    final String title = notification['title'];
    final String body = notification['body'];
    final String onTitle = data['onTitle'];
    final String onMessage = data['onMessage'];

    MessageModel model = MessageModel(
      title: title,
      body: body,
      onTitle: onTitle,
      onMessage: onMessage,
    );

    appBloc.addMessage(model);
  }
}
