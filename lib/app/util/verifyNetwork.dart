import 'dart:io';

class VerifyNetwork {
  Future<bool> verify() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }

      return false;
    } // try { ... }
    on SocketException catch(_) {
      return false;
    }
    catch (erro) {
      return false;
    } // catch(erro) { ... }
  } // bool verify() { ... }
}
