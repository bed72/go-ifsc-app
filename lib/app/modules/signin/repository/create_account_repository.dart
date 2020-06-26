import 'package:http/http.dart';

import '../../../../utils/urls.dart';
import '../../../core/models/user_model.dart';

class CreateAccountRepository {
  final Client http;
  Response response;

  CreateAccountRepository(this.http);

  Future<Response> doCreate(UserModel user) async {
    print('\n\n[API] create \nData = ${user.toMap()} \n\n');

    response = await http.post(
      Urls.create_account,
      body: user.toJson(),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('\n\n RESPONSE: ${response.body} \n\n');
      return response;
    } else {
      print('\n\n RESPONSE ERROR: ${response.body} \n\n');
      return response;
    }
  }
}
