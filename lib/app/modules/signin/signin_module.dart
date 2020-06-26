import 'package:go_ifsc/app/modules/signin/repository/create_account_repository.dart';
import 'package:go_ifsc/app/modules/signin/signin_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/modules/signin/signin_page.dart';
import 'package:http/http.dart';

class SigninModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SigninBloc(i.get<CreateAccountRepository>())),
        Bind((i) => CreateAccountRepository(i.get<Client>())),
        Bind((i) => Client())
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => SigninPage()),
      ];

  static Inject get to => Inject<SigninModule>.of();
}
