import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:go_ifsc/app/core/viewmodels/firebase_viewmodels.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseViewModels firebase = FirebaseViewModels();

  String _assets = "assets/animate/ifsc.flr";
  String _animationName = "ping";

  @override
  void initState() {
    super.initState();
    // Configurações das notificações
    firebase.setTokenNotification();
    // Configuração das rotas dependendo se o token da sessão ja foi setado
    Future.delayed(Duration(seconds: 5)).then(
      (value) => firebase.changeRoute(),
    );
  }

  @override
  void dispose() {
    super.dispose();
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
