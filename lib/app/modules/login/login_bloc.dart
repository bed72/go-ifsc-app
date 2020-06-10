import 'package:rxdart/rxdart.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'repository/login_repository.dart';

class LoginBloc extends Disposable {
  final LoginRepositoty _repository;
  String token;
  String email;
  String password;

  BehaviorSubject<String> _subjectEmail;
  BehaviorSubject<String> _subjectPassword;

  LoginBloc(this._repository) {
    _subjectEmail = BehaviorSubject<String>.seeded(this.email);
    _subjectPassword = BehaviorSubject<String>.seeded(this.password);
  }

  Stream<String> get getEmail => _subjectEmail.stream;

  Stream<String> get getPassword => _subjectPassword.stream;

  void setEmail(String value) {
    _subjectEmail.sink.add(value);
    getEmail.listen((event) => this.email = event);
  }

  void setPassword(String value) {
    _subjectPassword.sink.add(value);
    getPassword.listen((event) => this.password = event);
  }

  fetchLogin() async {
    token = await _repository.doLogin(this.email, this.password);
    print('\nOlá: $token \n');
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _subjectEmail.close();
    _subjectPassword.close();
  }
}
