import 'package:flutter/material.dart';
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
        body: Center(
          child: Text('Nada por enquanto!'),
        ),
      ),
    );
  }
}
