import 'package:flutter/material.dart';
import '../login/widgets/sigin_up_button.dart';
import 'package:go_ifsc/app/core/widgets/app_bar_widget.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  void initState() {
    super.initState();
  }

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

            Column(
              children: <Widget>[
                SignUpButton(
                  text: 'Já possui cadastro?',
                  textInfo: ' Login',
                  route: '/login',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
