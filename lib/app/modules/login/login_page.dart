import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/modules/login/login_bloc.dart';
import 'package:go_ifsc/app/modules/core/widgets/app_bar_widget.dart';
import 'package:go_ifsc/app/modules/core/widgets/input_text_widget.dart';
import 'package:go_ifsc/app/modules/login/widgets/sigin_up_button.dart';
import 'package:go_ifsc/app/modules/login/widgets/stagger_animation.dart';
import 'package:go_ifsc/app/modules/core/widgets/input_password_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final loginBloc = Modular.get<LoginBloc>();

  AnimationController _animationController;

  GlobalKey<FormState> _forKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      // Tempo para diminuir button e checar login 5 sec
      duration: Duration(seconds: 2),
    );

    _animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          Modular.to.pushReplacementNamed('/login/home');
        }
      },
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
    return Scaffold(
      body: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 27,
            ),
            // AppBar login
            AppTitleBar(title: 'Login'),
            // Stack vai ser para animar
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Form(
                  key: _forKey,
                  child: Column(
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
                          typeInput: TextInputType.emailAddress,
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
                      SignUpButton(
                        text: 'Não possui cadastro?',
                        textInfo: ' Cadastre-se',
                        route: '/login/signin',
                      ),
                    ],
                  ),
                ),
                // button animado Login
                StaggerAnimation(
                  controller: _animationController.view,
                  bloc: loginBloc,
                  forKey: _forKey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
