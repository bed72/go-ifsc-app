import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/app_module.dart';
import 'package:go_ifsc/app/modules/splash/splash_bloc.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(AppModule());
  SplashBloc bloc;

  setUp(() {
    bloc = AppModule.to.get<SplashBloc>();
  });

  group('SplashBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<SplashBloc>());
    });
  });
}
