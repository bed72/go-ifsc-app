import 'dart:io';

import 'package:http/http.dart';
import '../../../../utils/urls.dart';

class LoginRepositoty {
  final Client http;

  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZmZTJkNjY4LTNiOTAtNGQzMC1hMWFmLWNiZGRkMTdjZTAyZiIsImlhdCI6MTU5MTgyMjMxMywiZXhwIjoxNTkxODQwMzEzfQ.-6jGbuPVWmxi1YuVd5vAMJuvx1ipumhicB9MfObGt0M';

  LoginRepositoty(this.http);

  Future<String> doLogin(String email, String password) async {
    print('\n\n $email \n $password \n\n');
    Response response = await http.post(
      Urls.login,
      body: {"email": email, "password": password},
      headers: {HttpHeaders.authorizationHeader: 'bearer $token'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      return throw Exception('Erro ao realizar o Login :( ${response.body}');
    }
  }
}
