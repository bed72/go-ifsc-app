import 'package:flutter/material.dart';

import '../core/widgets/app_bar_widget.dart';
import '../login/widgets/sigin_up_button.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  GlobalKey<FormState> _forKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 27,
            ),
            // AppBar login
            AppTitleBar(title: 'Signin'),

            Form(
              key: _forKey,
              child: Column(
                children: <Widget>[
                  SignUpButton(
                    text: 'Já possui cadastro?',
                    textInfo: ' Login',
                    route: '/login/login',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
