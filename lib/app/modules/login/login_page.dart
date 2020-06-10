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

  void doLogin() {
    loginBloc.fetchLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Go IFSC"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 5),
              child: InputTextField(
                hintText: 'E-mail',
                typeIcon: Icon(
                  Icons.email,
                  color: Colors.white38,
                ),
                typeInput: TextInputType.text,
                maxLength: 128,
                color: Colors.white60,
                bloc: loginBloc.setEmail,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
              child: InputPasswordText(
                hintText: 'Password',
                typeIcon: Icon(
                  Icons.lock,
                  color: Colors.white38,
                ),
                typeInput: TextInputType.text,
                maxLength: 256,
                color: Colors.white60,
                bloc: loginBloc.setPassword,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
              child: RaisedButton(
                onPressed: () => doLogin(),
                padding: EdgeInsets.all(0.0),
                textColor: Colors.white,
                child: Text('Login'),
              ),
            ),
            StreamBuilder(
              stream: loginBloc.getEmail,
              builder: (context, AsyncSnapshot<String> snapshot) {
                return Text('${snapshot.data}');
              },
            )
          ],
        ),
      ),
    );
  }
}
