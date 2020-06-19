import 'package:flutter/material.dart';
import 'package:go_ifsc/themes/app_colors.dart';

class SliverTitleAppBar extends StatelessWidget {
  final String title;

  SliverTitleAppBar({@required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'Olá $title',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        background: Image.asset(
          'assets/img/sliver.jpg',
          fit: BoxFit.cover,
          color: AppColors.black54,
          colorBlendMode: BlendMode.darken,
        ),
      ),
    );
  }
}
