import 'package:go_ifsc/app/modules/signin/signin_module.dart';
import 'package:http/http.dart';
import 'repository/login_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/modules/home/home_module.dart';
import 'package:go_ifsc/app/modules/login/login_bloc.dart';
import 'package:go_ifsc/app/modules/login/login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginBloc(i.get<LoginRepositoty>())),
        Bind((i) => LoginRepositoty(i.get<Client>())),
        Bind((i) => Client())
      ];

  @override
  List<Router> get routers => [
        Router('/login', child: (_, args) => LoginPage()),
        Router(
          '/home',
          module: HomeModule(),
          transition: TransitionType.rightToLeftWithFade,
        ),
        Router(
          '/signin',
          module: SigninModule(),
          transition: TransitionType.rightToLeftWithFade,
        ),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
