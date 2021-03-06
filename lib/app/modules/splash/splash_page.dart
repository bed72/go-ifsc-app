import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:go_ifsc/app/core/services/shared_local_storage_service.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String _assets = "assets/animate/ifsc.flr";
  String _animationName = "ping";

  @override
  void initState() {
    super.initState();
    // Configuração das rotas dependendo se o token da sessão ja foi setado
    Future.delayed(Duration(seconds: 2)).then(
      (value) => _changeRoute(),
    );
  }

  // verifica rota
  void _changeRoute() {
    print('\nCheck Route: OK\n');
    SharedLocalStorageService.localShared.get('sessionToken').then(
          (value) => {
            value == null
                ? Modular.to.pushReplacementNamed('/login')
                : Modular.to.pushReplacementNamed('/home'),
          },
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
