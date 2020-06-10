import 'package:flare_flutter/flare_cache_builder.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String _animationName = "idle";
  final asset =
      AssetFlare(bundle: rootBundle, name: "assets/animate/Filip.flr");

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 10)).then(
      (value) => Modular.to.pushReplacementNamed('/login'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: FlareCacheBuilder(
                [asset],
                builder: (BuildContext context, bool isNone) {
                  return !isNone
                      ? Container(
                          child: Text('Go IFSC'),
                        )
                      : FlareActor.asset(
                          asset,
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          animation: _animationName,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
