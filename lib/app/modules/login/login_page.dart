import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/modules/login/login_bloc.dart';
import 'package:go_ifsc/app/modules/core/widgets/app_bar_widget.dart';
import 'package:go_ifsc/app/modules/login/widgets/sigin_up_button.dart';
import 'package:go_ifsc/app/modules/core/widgets/input_text_widget.dart';
import 'package:go_ifsc/app/modules/login/widgets/stagger_animation.dart';

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
                            margin: EdgeInsets.only(top: 50.0),
                          ),
                          passwordTextField(loginBloc),
                          // Button create user
                          SignUpButton(
                            text: 'Não possui cadastro?',
                            textInfo: ' Cadastre-se',
                            route: '/login/signin',
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                // button animado Login
                submitButton(loginBloc),
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
            color: Colors.white38,
          ),
          errorText: () => snapshot.error,
          typeInput: TextInputType.emailAddress,
          maxLength: 128,
          color: Colors.white60,
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
            color: Colors.white38,
          ),
          obscure: true,
          errorText: () => snapshot.error,
          typeInput: TextInputType.text,
          maxLength: 256,
          color: Colors.white60,
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
