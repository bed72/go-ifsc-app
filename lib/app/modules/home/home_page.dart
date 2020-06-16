import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_ifsc/app/modules/home/widgets/card_widget.dart';
import 'package:go_ifsc/app/modules/home/widgets/sliver_app_bar_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, condition) {
          return <Widget>[
            SliverTitleAppBar(
              title: 'Gabriel',
            )
          ];
        },
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: _buildList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return AnimationLimiter(
      child: GridView.builder(
        itemCount: 5,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 5, bottom: 10),
        primary: true,
        addAutomaticKeepAlives: true,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: 1,
            child: ScaleAnimation(
              child: GestureDetector(
                child: null,
                onTap: () => null,
              ),
            ),
          );
        },
      ),
    );
  }
}
