import 'package:flutter/material.dart';

class StaggerAnimation extends StatelessWidget {
  final AnimationController controller;
  final bloc;
  final snapshot;

  StaggerAnimation(
      {@required this.controller, @required this.bloc, @required this.snapshot})
      : buttonSqueeze = Tween(
          begin: 320.0,
          end: 60.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.150),
          ),
        ),
        buttonZoomOut = Tween(
          begin: 60.0,
          end: 1000.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 1, curve: Curves.bounceOut),
          ),
        );
  // Animação para incolher button login
  final Animation<double> buttonSqueeze;

  // Animação para cobrir tela antes de realizar push para a home
  final Animation<double> buttonZoomOut;

  Widget _builderAnimation(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.only(bottom: 70),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          // snapshot.hasData => retorna o bool da Stream
          if (snapshot.hasData == true) {
            bloc.fetchLogin();
            controller.forward();
          } else {
            print('\n Error: ${snapshot.data} \n');
          }
        },
        child: buttonZoomOut.value <= 60
            ? Container(
                width: buttonSqueeze.value,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(27),
                  ),
                ),
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
}
