import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/modules/login/login_module.dart';
import 'package:go_ifsc/app/modules/login/login_page.dart';

import '../../../../themes/app_colors.dart';
import '../../../core/services/connection_viewmodel.dart';
import '../../../core/widgets/global_snack_widget.dart';
import '../../../core/widgets/snackbar_widget.dart';

class ButtonAccount extends StatefulWidget {
  final bloc;
  final snapshot;

  ButtonAccount({
    @required this.bloc,
    @required this.snapshot,
  });

  @override
  _ButtonAccountState createState() => _ButtonAccountState();
}

class _ButtonAccountState extends State<ButtonAccount> {
  bool _stateButton = false;

  void stateBool() {
    setState(() {
      _stateButton = !_stateButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: _stateButton == false
          ? () {
              stateBool();

              _create(context, widget.snapshot, widget.bloc);
            }
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          27,
        ),
      ),
      child: _stateButton == false
          ? Container(
              width: 360,
              height: 60,
              alignment: Alignment.center,
              child: Text(
                'Create Account',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.3,
                ),
              ),
            )
          : Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                backgroundColor: AppColors.primary,
                strokeWidth: 3.5,
              ),
            ),
    );
  }

  _create(BuildContext context, snapshot, bloc) async {
    // snapshot => esta valido ou não os campos
    if (snapshot.hasData == true) {
      // Instancia da classe Singleton para conexão
      var _checkConnection = ConnectionController.instance.checkConection();
      // Verificando se há conexão com a internet
      await _checkConnection.then(
        (value) => {
          // Se falso então não a conexão
          if (value == false)
            {
              // dispacha uma snackbar avisando o usuario que não a conexão
              GlobalScaffold.instance.showSnachbar(
                _snackConnection(
                  context,
                  'Não a conexão!',
                ),
              ),
              stateBool(),
            }
          else if (value == true)
            {
              // Caso haja conexão validação de login e senha
              bloc.fetchCreateAccount().then(
                    (value) => {
                      if (value.statusCode == 200 || value.statusCode == 201)
                        {
                          // realizar melhoria na busca de emails já cadastrados
                          //Modular.link.pushReplacementNamed('/'),
                          Modular.to.pushReplacementNamed('/login'),
                        }
                      else if (value.statusCode >= 400)
                        {
                          GlobalScaffold.instance.showSnachbar(
                            _snackConnection(
                              context,
                              'Credenciais inválidas',
                            ),
                          ),
                          stateBool(),
                        }
                    },
                  ),
            }
        },
      );
    } else if (snapshot.hasData == false) {
      GlobalScaffold.instance.showSnachbar(
        _snackbar(context, snapshot),
      );
      stateBool();
    }
  }

  Widget _snackbar(
    BuildContext context,
    dynamic snapshot,
  ) =>
      snackbarWidget(
        context,
        snapshot,
        AppColors.red,
        4,
      );

  Widget _snackConnection(BuildContext context, text) =>
      snackbarConnectionWidget(
        '$text',
        context,
        Colors.grey.shade800,
        4,
      );
}
