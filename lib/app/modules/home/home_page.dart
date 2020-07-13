import 'package:flutter/material.dart';
import 'package:go_ifsc/app/app_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/core/models/message_model.dart';

import 'package:go_ifsc/app/modules/home/widgets/sliver_app_bar_widget.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final appBloc = Modular.get<AppBloc>();

  @override
  void initState() {
    super.initState();
    appBloc.allMessages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, condition) {
          return <Widget>[
            SliverTitleAppBar(
              title: 'Notícias',
            )
          ];
        },
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: StreamBuilder(
                  stream: appBloc.messages,
                  builder:
                      (context, AsyncSnapshot<List<MessageModel>> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        padding: EdgeInsets.only(top: 20),
                        child: _buildList(snapshot),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(AsyncSnapshot<List<MessageModel>> snapshot) {
    return AnimationLimiter(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: snapshot.data.length,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 5, bottom: 10),
        primary: true,
        addAutomaticKeepAlives: true,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: 1,
            child: ScaleAnimation(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: CardWidget(
                  route: '/home/details/${snapshot.data[index].id}',
                  title: snapshot.data[index].title ??
                      snapshot.data[index].onTitle,
                  body: snapshot.data[index].body ??
                      snapshot.data[index].onMessage,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
