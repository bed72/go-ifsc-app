import 'package:rxdart/rxdart.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginBloc extends Disposable {
  String email = "";
  String password = "";

  BehaviorSubject<String> _subjectEmail;
  BehaviorSubject<String> _subjectPassword; // Mudar pois pega a ultima senha

  LoginBloc({this.email, this.password}) {
    _subjectEmail = BehaviorSubject<String>.seeded(this.email);
    _subjectPassword = BehaviorSubject<String>.seeded(this.password);
  }

  Stream<String> get getEmail => _subjectEmail.stream;

  Stream<String> get getPassword => _subjectPassword.stream;

  void setEmail(String value) {
    _subjectEmail.sink.add(value);
  }

  void setPassword(String value) {
    _subjectPassword.sink.add(value);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _subjectEmail.close();
    _subjectPassword.close();
  }
}
