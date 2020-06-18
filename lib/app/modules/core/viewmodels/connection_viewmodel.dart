import 'dart:io';

class ConnectionController {
  static final ConnectionController instance = ConnectionController();

  Future checkConection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // A conexão
      }
    } on SocketException catch (_) {
      return false; // Não a conexão
    }
  }
}
