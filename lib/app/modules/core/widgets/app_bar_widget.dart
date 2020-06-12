import 'package:flutter/material.dart';

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
                    fontFamily: 'Google',
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
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
