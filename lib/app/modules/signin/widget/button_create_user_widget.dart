import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../themes/app_colors.dart';
import '../../../core/services/connection_viewmodel.dart';
import '../../../core/widgets/global_snack_widget.dart';
import '../../../core/widgets/snackbar_widget.dart';

class ButtonAccount extends StatelessWidget {
  final bloc;
  final snapshot;

  ButtonAccount({
    @required this.bloc,
    @required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    bool _stateButton = false;

    return RaisedButton(
      onPressed: _stateButton == false
          ? () {
              _stateButton = !_stateButton;
              print('\n\n SNAPP ${snapshot.hasData}\n\n');
              _create(context, snapshot, bloc);
            }
          : () {},
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

  _create(BuildContext context, snapshot, bloc) {
    // snapshot => esta valido ou não os campos
    if (snapshot.hasData == true) {
      // Instancia da classe Singleton para conexão
      var _checkConnection = ConnectionController.instance.checkConection();
      // Verificando se há conexão com a internet
      _checkConnection.then(
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
            }
          else if (value == true)
            {
              // Caso haja conexão validação de login e senha
              bloc.fetchCreateAccount().then(
                    (value) => {
                      if (value.statusCode == 200 || value.statusCode == 201)
                        {
                          bloc.fetchCreateAccount(),
                          Modular.to.pushReplacementNamed('/login'),
                        }
                      else if (value.statusCode == 400 ||
                          value.statusCode == 401)
                        {
                          GlobalScaffold.instance.showSnachbar(
                            _snackConnection(
                              context,
                              'Credenciais inválidas',
                            ),
                          ),
                        }
                    },
                  ),
            }
        },
      );
    } else {
      GlobalScaffold.instance.showSnachbar(
        _snackbar(context, snapshot),
      );
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
