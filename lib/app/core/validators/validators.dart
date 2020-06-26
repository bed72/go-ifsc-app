import 'dart:async';

extension ValidationExtension on String {
  bool isValidPassword() => this.length >= 6;

  bool isValidOuters() => this.length >= 3;

  bool isFieldEmpty() => this?.isEmpty ?? true;

  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
            caseSensitive: false)
        .hasMatch(this);
  }
}

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (!email.isFieldEmpty() && email.isValidEmail()) {
      sink.add(email);
    } else {
      sink.addError('E-mail inválido!');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.isValidPassword() && !password.isFieldEmpty()) {
      sink.add(password);
    } else {
      sink.addError('Senha Inválida!');
    }
  });

  final validateOuters = StreamTransformer<String, String>.fromHandlers(
      handleData: (search, sink) {
    if (search.isValidOuters() && !search.isFieldEmpty()) {
      sink.add(search);
    } else {
      sink.addError('Opss!');
    }
  });
}
