import 'dart:io';

import 'package:http/http.dart';
import '../../../../utils/urls.dart';

class LoginRepositoty {
  final Client http;

  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQ5N2IzMmY2LWUxYjItNDZkNC05MjViLTAyMzVhYzIwZDUxNCIsImlhdCI6MTU5MTY3MjExNywiZXhwIjoxNTkxNjkwMTE3fQ.jNZipOKS1Dn4dzvbSMClXpACRrXOYbCEp9KlTi80uOs';

  LoginRepositoty(this.http);

  Future<String> doLogin(String email, String password) async {
    Response response = await http.post(
      Urls.login,
      body: {"email": email, "password": password},
      headers: {HttpHeaders.authorizationHeader: 'bearer $token'},
    );
    if (response.statusCode >= 200 && response.statusCode < 400) {
      print('\n AQUII: ${response.body} \n');
      return response.body;
    } else {
      return throw Exception('Erro ao realizar o Login :(');
    }
  }
}
