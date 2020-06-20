import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_ifsc/app/core/services/shared_local_storage_service.dart';

class FirebaseViewModels {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  setTokenNotification() {
    _fcm.getToken().then(
      (String token) async {
        assert(token != null);
        print('\n\nToken Firebase: $token \n\n');
        // Setando token do firebase
        changeToken(token);
      },
    );
  }

  // Metodo para setar token do firebase
  Future changeToken(String token) async {
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
