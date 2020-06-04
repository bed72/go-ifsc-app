import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/modules/login/login_bloc.dart';
import 'package:go_ifsc/app/modules/login/login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginBloc()),
      ];

  @override
  List<Router> get routers => [
        Router('/login', child: (_, args) => LoginPage()),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
