import 'package:flutter/material.dart';
import 'package:go_ifsc/themes/app_colors.dart';

import '../../../../themes/app_colors.dart';

class CardWidget extends StatefulWidget {
  final String title;
  final String body;

  CardWidget({
    Key key,
    @required this.title,
    @required this.body,
  }) : super(key: key);
  @override
  _CardWidgetState createState() => _CardWidgetState(
        title: title,
        body: body,
      );
}

class _CardWidgetState extends State<CardWidget> {
  final String title;
  final String body;

  _CardWidgetState({
    @required this.title,
    @required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: AppColors.black54,
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.notifications,
                          size: 32.0,
                          color: AppColors.white38,
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Text(
                          this.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      left: 10.0,
                      right: 10.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      this.body,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Mais ...',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: AppColors.white,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.touch_app,
                        ),
                        iconSize: 22,
                        tooltip: 'Mais Informações!',
                        onPressed: () {},
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
