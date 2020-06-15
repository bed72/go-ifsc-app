import 'package:connectivity/connectivity.dart';

class ConnectionController {
  static final ConnectionController instance = ConnectionController();

  Future<bool> checkConection() async {
    var _connection = await Connectivity().checkConnectivity();

    if (_connection == ConnectivityResult.none)
      return true; // Não a conexão
    else
      return false; // A conexão
  }
}
