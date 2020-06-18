import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../core/services/shared_local_storage_service.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  String _assets = "assets/animate/ifsc.flr";
  String _animationName = "ping";

  @override
  void initState() {
    super.initState();
    notification();
    Future.delayed(Duration(seconds: 5)).then(
      (value) => Modular.to.pushReplacementNamed('/login'),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void notification() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('\n\nonMessage: ${message.runtimeType}\n\n');
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print('\n\nonLaunch: ${message.runtimeType}\n\n');
      },
      onResume: (Map<String, dynamic> message) async {
        print('\n\nonResume: ${message.runtimeType}\n\n');
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
        print('\n\nSEU TOKEN: $token \n\n');
        changeToken(token);
      },
    );
  }

  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      return data;
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      return notification;
    }
    return null;
  }

  Future changeToken(String token) async {
    await SharedLocalStorageService.localShared.put('tokenFirebase', token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 200,
              height: 300,
              child: FlareActor(
                _assets,
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: _animationName,
              ),
            )
          ],
        ),
      ),
    );
  }
}
