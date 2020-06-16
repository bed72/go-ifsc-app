import 'package:http/http.dart';
import 'package:go_ifsc/utils/urls.dart';

class LoginRepositoty {
  final Client http;

  Response response;

  LoginRepositoty(this.http);

  Future<Response> doLogin(String email, String password) async {
    print('\n\n[API] login \nE-mail = $email \nPassword = [...] \n\n');

    response = await http.post(
      Urls.login,
      body: {"email": email, "password": password},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      return response;
    }
  }
}
