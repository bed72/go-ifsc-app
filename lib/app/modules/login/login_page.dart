import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/core/widgets/button_navigate.dart';
import 'package:go_ifsc/app/modules/login/login_bloc.dart';
import 'package:go_ifsc/app/core/widgets/app_bar_widget.dart';
import 'package:go_ifsc/app/core/widgets/input_text_widget.dart';

import 'package:go_ifsc/app/modules/login/widgets/stagger_animation.dart';
import 'package:go_ifsc/themes/app_colors.dart';

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
    loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Stack vai ser para animar
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 27,
                    ),
                    // AppBar login
                    AppTitleBar(title: 'Login'),
                    // Form
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 15, left: 20, right: 20),
                      child: Column(
                        children: <Widget>[
                          emailTextFiel(loginBloc),
                          Container(
                            margin: EdgeInsets.only(top: 30.0),
                          ),
                          passwordTextField(loginBloc),
                          // Button create user
                          ButtonNavigate(
                            text: 'Não possui cadastro?',
                            textInfo: ' Cadastre-se',
                            position: 150,
                            route: '/signin',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  // padding: EdgeInsets.all(15),
                  // margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: submitButton(loginBloc),
                )
                // button animado Login
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget emailTextFiel(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.getEmail,
      builder: (context, snapshot) {
        return InputTextField(
          hintText: 'exemple@email.com',
          labelText: 'E-mail',
          typeIcon: Icon(
            Icons.email,
            color: AppColors.white38,
          ),
          errorText: () => snapshot.error,
          typeInput: TextInputType.emailAddress,
          maxLength: 128,
          color: AppColors.white60,
          bloc: bloc.changeEmail,
        );
      },
    );
  }

  Widget passwordTextField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.getPassword,
      builder: (context, snapshot) {
        return InputTextField(
          hintText: '123...',
          labelText: 'Password',
          typeIcon: Icon(
            Icons.lock,
            color: AppColors.white38,
          ),
          obscure: true,
          errorText: () => snapshot.error,
          typeInput: TextInputType.text,
          maxLength: 256,
          color: AppColors.white60,
          bloc: bloc.changePassword,
        );
      },
    );
  }

  Widget submitButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return StaggerAnimation(
          controller: _animationController.view,
          bloc: bloc,
          snapshot: snapshot,
        );
      },
    );
  }
}
