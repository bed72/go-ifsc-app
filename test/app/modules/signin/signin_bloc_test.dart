import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/app_module.dart';
import 'package:go_ifsc/app/modules/signin/signin_bloc.dart';
import 'package:go_ifsc/app/modules/signin/signin_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(SigninModule());
  SigninBloc bloc;

  setUp(() {
    bloc = SigninModule.to.get<SigninBloc>();
  });

  group('SigninBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<SigninBloc>());
    });
  });
}
