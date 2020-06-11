import 'package:rxdart/rxdart.dart';
import 'repository/login_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginBloc extends Disposable {
  final LoginRepositoty _repository;
  String token = "";
  String email = "";
  String password = "";

  BehaviorSubject<String> _subjectToken;
  BehaviorSubject<String> _subjectEmail;
  BehaviorSubject<String> _subjectPassword;

  LoginBloc(this._repository) {
    _subjectToken = BehaviorSubject<String>.seeded(this.token);
    _subjectEmail = BehaviorSubject<String>.seeded(this.email);
    _subjectPassword = BehaviorSubject<String>.seeded(this.password);
  }
  Stream<String> get getToken => _subjectToken.stream;

  Stream<String> get getEmail => _subjectEmail.stream;

  Stream<String> get getPassword => _subjectPassword.stream;

  void setToken(String value) {
    //print('\n\nToken ${this.token}  \n\n');
    _subjectToken.sink.add(value);
    getToken.listen((event) => this.token = event);
  }

  void setEmail(String value) {
    _subjectEmail.sink.add(value);
    getEmail.listen((event) => this.email = event);
  }

  void setPassword(String value) {
    _subjectPassword.sink.add(value);
    getPassword.listen((event) => this.password = event);
  }

  fetchLogin() async {
    print('\n\nAntes ${this.email} \n ${this.password} \n\n');
    token = await _repository.doLogin(this.email, this.password);
    setToken(token);
    //print('\nOlá: $token \n');
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _subjectToken.close();
    _subjectEmail.close();
    _subjectPassword.close();
  }
}
