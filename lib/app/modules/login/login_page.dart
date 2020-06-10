import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/modules/login/login_bloc.dart';
import 'package:go_ifsc/app/modules/login/widgets/app_bar_widget.dart';
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
    /// double screenWidth = MediaQuery.of(context).size.width;
    double statusWidth = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: statusWidth,
                  ),
                  // AppBar login
                  AppBarLogin(),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0, left: 20, right: 20, bottom: 5),
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
                          padding: EdgeInsets.only(
                              top: 35, left: 20, right: 20, bottom: 5),
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
                          padding: EdgeInsets.only(
                              top: 25, left: 20, right: 20, bottom: 10),
                          child: SizedBox(
                            height: 52,
                            child: RaisedButton(
                              onPressed: () {
                                doLogin();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.green),
                              ),
                              padding: EdgeInsets.all(5.0),
                              textColor: Colors.white,
                              child: Text(
                                'Signin',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 5, left: 30, right: 20, bottom: 10),
                          child: Text(
                            'Signup',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
