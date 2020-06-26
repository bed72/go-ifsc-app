import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/themes/app_colors.dart';

class ButtonNavigate extends StatelessWidget {
  final String text;
  final String textInfo;
  final double position;
  final String route;

  ButtonNavigate({
    @required this.text,
    @required this.textInfo,
    @required this.position,
    @required this.route,
  });

  Widget _textBold(BuildContext context, String text) {
    return Text(
      '$text',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
        fontSize: 15,
        letterSpacing: 0.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      padding: EdgeInsets.only(
        top: this.position,
      ),
      onPressed: () {
        Modular.to.pushReplacementNamed(this.route);
      },
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Row contents horizontally,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "${this.text} ",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: AppColors.white,
              fontSize: 15,
              letterSpacing: 0.5,
            ),
          ),
          _textBold(context, this.textInfo),
        ],
      ),
    );
  }
}
