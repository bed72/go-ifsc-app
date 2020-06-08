import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/modules/login/login_bloc.dart';
import 'package:go_ifsc/app/modules/login/widgets/input_text_widget.dart';
import 'package:go_ifsc/app/modules/login/widgets/input_password_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginBloc = Modular.get<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Go IFSC"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 5),
                child: InputTextField(
                  hintText: 'E-mail',
                  typeIcon: Icon(
                    Icons.email,
                    color: Colors.white38,
                  ),
                  typeInput: TextInputType.text,
                  maxLength: 128,
                  color: Colors.white60,
                  onChanged: loginBloc,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
                child: InputPasswordText(
                  hintText: 'Password',
                  typeIcon: Icon(
                    Icons.lock,
                    color: Colors.white38,
                  ),
                  typeInput: TextInputType.text,
                  maxLength: 256,
                  color: Colors.white60,
                  onChanged: loginBloc,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
