import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'repository/login_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/core/validators/validators.dart';
import 'package:go_ifsc/app/core/services/shared_local_storage_service.dart';

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

  Future<Response> fetchLogin() async {
    Response _token;
    final String validEmail = _emailController.value;
    final String validPassword = _passwordController.value;
    _token = await _repositoryController.doLogin(validEmail, validPassword);
    // Setando token da sessão
    SharedLocalStorageService.localShared.put('sessionToken', _token.body);
    return _token;
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _tokenController.close();
    _emailController.close();
    _passwordController.close();
  }
}
