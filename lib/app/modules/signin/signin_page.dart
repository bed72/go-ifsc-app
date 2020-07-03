import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:go_ifsc/app/core/widgets/app_bar_widget.dart';
import 'package:go_ifsc/app/core/widgets/button_navigate.dart';
import 'package:go_ifsc/app/modules/signin/widget/button_create_user_widget.dart';

import '../../../themes/app_colors.dart';

import '../../core/widgets/input_text_widget.dart';

import 'signin_bloc.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final signinBloc = Modular.get<SigninBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    signinBloc.dispose();
    super.dispose();
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

            Container(
              margin: EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  nameTextFiel(signinBloc),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                  ),
                  emailTextFiel(signinBloc),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                  ),
                  passwordTextField(signinBloc),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                  ),
                  submitButton(signinBloc),
                  ButtonNavigate(
                    text: 'Já possui cadastro?',
                    textInfo: ' Login',
                    position: 35,
                    route: '/login',
                  ),
                ],
              ),
            ),
            // Button Create Account
          ],
        ),
      ),
    );
  }

  Widget nameTextFiel(SigninBloc bloc) {
    return StreamBuilder(
      stream: bloc.getName,
      builder: (context, snapshot) {
        return InputTextField(
          hintText: 'Ana',
          labelText: 'Nome',
          typeIcon: Icon(
            Icons.account_box,
            color: AppColors.white38,
          ),
          errorText: () => snapshot.error,
          typeInput: TextInputType.text,
          maxLength: 128,
          color: AppColors.white60,
          bloc: bloc.changeName,
        );
      },
    );
  }

  Widget emailTextFiel(SigninBloc bloc) {
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

  Widget passwordTextField(SigninBloc bloc) {
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

  Widget submitButton(SigninBloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return ButtonAccount(
          bloc: bloc,
          snapshot: snapshot,
        );
      },
    );
  }
}
