import 'package:go_ifsc/app/modules/splash/splash_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/modules/splash/splash_page.dart';

class SplashModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SplashBloc()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => SplashPage()),
      ];

  static Inject get to => Inject<SplashModule>.of();
}
