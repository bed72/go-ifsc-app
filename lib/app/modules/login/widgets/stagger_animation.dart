import 'package:flutter/material.dart';
import 'package:go_ifsc/app/modules/core/viewmodels/connection_viewmodel.dart';
import 'package:go_ifsc/app/modules/core/widgets/snackbar_widget.dart';
import 'package:go_ifsc/app/modules/core/widgets/global_snack_widget.dart';

class StaggerAnimation extends StatelessWidget {
  final AnimationController controller;
  final bloc;
  final snapshot;

  StaggerAnimation({
    @required this.controller,
    @required this.bloc,
    @required this.snapshot,
  })  : buttonSqueeze = Tween(
          begin: 290.0,
          end: 60.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.160),
          ),
        ),
        buttonZoomOut = Tween(
          begin: 60.0,
          end: 1000.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 1, curve: Curves.bounceInOut),
          ),
        );
  // Animação para incolher button login
  final Animation<double> buttonSqueeze;

  // Animação para cobrir tela antes de realizar push para a home
  final Animation<double> buttonZoomOut;

  Widget _builderAnimation(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.only(bottom: 75),
      child: RaisedButton(
        onPressed: () {
          _login(context, snapshot, bloc);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            buttonZoomOut.value < 500 ? 27 : 0,
          ),
        ),
        child: buttonZoomOut.value <= 60
            ? Container(
                width: buttonSqueeze.value,
                height: 60,
                alignment: Alignment.center,
                child: _buildInside(context),
              )
            : Container(
                width: buttonZoomOut.value,
                height: buttonZoomOut.value,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: buttonZoomOut.value < 500
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                ),
              ),
      ),
    );
  }

  Widget _snackbar(
    BuildContext context,
    dynamic snapshot,
  ) =>
      snackbarWidget(
        context,
        snapshot,
        Colors.red.shade300,
        4,
      );

  Widget _snackConnection(BuildContext context, text) =>
      snackbarConnectionWidget(
        '$text',
        context,
        Colors.grey.shade800,
        4,
      );

  Widget _buildInside(BuildContext context) {
    // o texto ainda cabe
    if (buttonSqueeze.value > 75) {
      return Text(
        'Sign in',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      );
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 1.5,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _builderAnimation,
      animation: controller,
    );
  }

  // Melhorar isso pois a muita responsabilidade na view
  _login(BuildContext context, snapshot, bloc) {
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
              bloc.fetchLogin().then(
                    (value) => {
                      if (value.statusCode == 200 || value.statusCode == 201)
                        {
                          bloc.fetchLogin(),
                          controller.forward(),
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
}
