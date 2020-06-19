import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/app_bloc.dart';
import 'package:go_ifsc/app/core/models/message_model.dart';
import 'package:go_ifsc/app/core/services/shared_local_storage_service.dart';

class FirebaseViewModels {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final _coreBloc = Modular.get<AppBloc>();

  void notification() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('\n\nonMessage: $message\n\n');
        _setMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('\n\nonLaunch: $message\n\n');
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('\n\nonResume: $message\n\n');
        _setMessage(message);
      },
    );
    _fcm.requestNotificationPermissions(
      IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true,
        provisional: true,
      ),
    );
    _fcm.onIosSettingsRegistered.listen(
      (IosNotificationSettings settings) {
        print('\n\nConfigurações Registradas: $settings\n\n');
      },
    );
    _fcm.getToken().then(
      (String token) async {
        assert(token != null);
        print('\n\nToken Firebase: $token \n\n');
        // Setando token do firebase
        _changeToken(token);
      },
    );
  }

  // Setando messagem em DB
  void _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    // final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    final String mMessage = notification['message'];

    MessageModel model =
        MessageModel(title: title, body: body, message: mMessage);

    _coreBloc.addMessage(model);
  }

  // Metodo para setar token do firebase
  Future _changeToken(String token) async {
    await SharedLocalStorageService.localShared.put('tokenFirebase', token);
  }

  // verifica rota
  void changeRoute() {
    SharedLocalStorageService.localShared.get('sessionToken').then(
          (value) => {
            value == null
                ? Modular.to.pushReplacementNamed('/login')
                : Modular.to.pushReplacementNamed('/home'),
          },
        );
  }
}
