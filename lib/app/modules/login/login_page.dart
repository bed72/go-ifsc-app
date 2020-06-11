import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/modules/login/login_bloc.dart';
import 'package:go_ifsc/app/modules/login/widgets/app_bar_widget.dart';
import 'package:go_ifsc/app/modules/login/widgets/input_text_widget.dart';
import 'package:go_ifsc/app/modules/login/widgets/input_password_widget.dart';
import 'package:go_ifsc/app/modules/login/widgets/sigin_up_button.dart';
import 'package:go_ifsc/app/modules/login/widgets/stagger_animation.dart';

import 'package:flutter/scheduler.dart' show timeDilation;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final loginBloc = Modular.get<LoginBloc>();

  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      // Tempo para diminuir button e checar login 5 sec
      duration: Duration(seconds: 5),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void doLogin() {
    loginBloc.fetchLogin();
  }

  @override
  Widget build(BuildContext context) {
    // Simula tempo do app timeDilation 4 x mais lento
    timeDilation = 1;
    return Scaffold(
      body: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Stack vai ser para animar
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Form(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 27,
                      ),
                      // AppBar login
                      AppBarLogin(),

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
                      // Button create user
                      SignUpButton(),
                    ],
                  ),
                ),
                // button animado Login
                StaggerAnimation(
                  controller: _animationController.view,
                  bloc: loginBloc,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
