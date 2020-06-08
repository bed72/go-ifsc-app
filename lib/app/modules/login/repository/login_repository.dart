import 'package:go_ifsc/app/modules/core/models/user_model.dart';
import 'package:http/http.dart';

class LoginRepositoty {
  final Client http;

  LoginRepositoty(this.http);

  Future<UserModel> doLogin(String email, String password) async {
    Response response = await http.post('url');
  }
}
