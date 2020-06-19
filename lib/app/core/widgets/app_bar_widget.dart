import 'package:flutter/material.dart';
import 'package:go_ifsc/themes/app_colors.dart';

class AppTitleBar extends StatelessWidget {
  final String title;

  const AppTitleBar({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  this.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      height: 120,
    );
  }
}
