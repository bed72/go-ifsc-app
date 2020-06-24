import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/core/services/fcm_service.dart';
import 'package:go_ifsc/app/core/widgets/global_snack_widget.dart';
import 'package:go_ifsc/themes/app_theme.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Go IFSC',
      theme: AppTheme(context).defaultTheme,
      darkTheme: AppTheme(context).defaultThemeDark,
      builder: (context, child) {
        return Scaffold(
          key: GlobalScaffold.instance.getScaffkey,
          body: AppPushs(
            child: child,
          ),
        );
      },
      initialRoute: Modular.initialRoute,
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
