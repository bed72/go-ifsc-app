import 'package:flutter/material.dart';
import 'package:go_ifsc/app/modules/login/widgets/input_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 5),
            child: InputsWidget(
              'E-mail',
              Icon(
                Icons.email,
                color: Colors.white38,
              ),
              TextInputType.emailAddress,
              128,
              false,
              Colors.white60,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
            child: InputsWidget(
              'Password',
              Icon(
                Icons.visibility_off,
                color: Colors.white38,
              ),
              TextInputType.text,
              256,
              true,
              Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}
