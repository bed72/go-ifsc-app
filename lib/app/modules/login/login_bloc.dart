import 'package:rxdart/rxdart.dart';
import 'repository/login_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/modules/login/validators/validators.dart';

class LoginBloc extends Disposable with Validators {
  final LoginRepositoty _repositoryController;

  final _tokenController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  LoginBloc(this._repositoryController);

  Stream<String> get getToken => _tokenController.stream;
  Stream<String> get getEmail =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get getPassword =>
      _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid => CombineLatestStream.combine2(
      getEmail, getPassword, (email, password) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Future<String> fetchLogin() async {
    final String validEmail = _emailController.value;
    final String validPassword = _passwordController.value;
    return await _repositoryController.doLogin(validEmail, validPassword);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _tokenController.close();
    _emailController.close();
    _passwordController.close();
  }
}
