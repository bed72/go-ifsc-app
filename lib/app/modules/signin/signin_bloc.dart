import 'package:http/http.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_ifsc/app/modules/signin/repository/create_account_repository.dart';

import '../../core/models/user_model.dart';
import '../../core/services/shared_local_storage_service.dart';
import '../../core/validators/validators.dart';

class SigninBloc extends Disposable with Validators {
  final CreateAccountRepository _repositoryController;

  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  SigninBloc(this._repositoryController);

  Stream<String> get getName =>
      _nameController.stream.transform(validateOuters);
  Stream<String> get getEmail =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get getPassword =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get submitValid => CombineLatestStream.combine3(
      getName, getEmail, getPassword, (name, email, password) => true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  void fetchCreateAccount() async {
    String getToken;
    await SharedLocalStorageService.localShared.get('tokenFirebase').then(
          (value) => {
            getToken = value.toString(),
          },
        );

    final String validName = _nameController.value;
    final String validEmail = _emailController.value;
    final String validToken = getToken;
    final String validPassword = _passwordController.value;
    final String validConfirmPassword = _passwordController.value;

    UserModel userModel = UserModel(
      name: validName,
      email: validEmail,
      tokenCell: validToken,
      password: validPassword,
      passwordConfirmation: validConfirmPassword,
    );

    await _repositoryController.doCreate(userModel);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _nameController.close();
    _emailController.close();
    _passwordController.close();
  }
}
