import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/modules/home/home_module.dart';

import 'package:go_ifsc/app/modules/login/login_module.dart';
import 'package:go_ifsc/app/modules/splash/splash_bloc.dart';
import 'package:go_ifsc/app/modules/splash/splash_page.dart';

class SplashModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SplashBloc()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => SplashPage()),
        Router(
          '/login',
          module: LoginModule(),
          transition: TransitionType.rightToLeftWithFade,
        ),
        Router(
          '/home',
          module: HomeModule(),
          transition: TransitionType.rightToLeftWithFade,
        ),
      ];

  static Inject get to => Inject<SplashModule>.of();
}
