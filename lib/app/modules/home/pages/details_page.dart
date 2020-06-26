import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/app_bloc.dart';
import 'package:go_ifsc/app/core/models/message_model.dart';
import 'package:go_ifsc/app/core/widgets/app_bar_widget.dart';
import 'package:go_ifsc/app/core/widgets/button_navigate.dart';
import 'package:go_ifsc/themes/app_colors.dart';

class DetailsPage extends StatefulWidget {
  final String id;

  DetailsPage({this.id});

  @override
  _DetailsPageState createState() => _DetailsPageState(id: this.id);
}

class _DetailsPageState extends State<DetailsPage> {
  final appBloc = Modular.get<AppBloc>();
  final String id;
  List<MessageModel> message;

  _DetailsPageState({@required this.id});

  @override
  void initState() {
    super.initState();
    appBloc.searcMessageDetails(this.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 27,
          ),
          // AppBar login
          AppTitleBar(title: 'Details'),
          StreamBuilder(
            stream: appBloc.details,
            builder: (context, AsyncSnapshot<MessageModel> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        left: 5,
                      ),
                      child: Text(
                        '${snapshot.data.title}',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: AppColors.white,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: AppColors.white,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          ButtonNavigate(
            text: 'Voltar a',
            textInfo: ' Home',
            position: 80,
            route: '/home',
          ),
        ],
      ),
    );
  }
}
