import './pages/details_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/modules/home/home_bloc.dart';
import 'package:go_ifsc/app/modules/home/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeBloc()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
        Router(
          '/details/:id',
          child: (_, args) => DetailsPage(id: args.params['id']),
          transition: TransitionType.rightToLeftWithFade,
        ),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
