import 'package:flutter/material.dart';
import 'package:go_ifsc/themes/app_colors.dart';

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
      padding: EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: AppColors.black54,
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      top: 8.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.notifications,
                          size: 24.0,
                          color: Theme.of(context).buttonColor,
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Text(
                          this.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        child: Flexible(
                          child: Text(
                            this.body,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
