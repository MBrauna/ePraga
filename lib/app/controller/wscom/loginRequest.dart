import 'dart:convert';

import 'package:unique_identifier/unique_identifier.dart';
import 'package:http/http.dart' as http;
import './../../../config/config.dart' as config;

class LoginRequest {
  static Future<Map<String, dynamic>> getLogin({int accessCode, String password}) async{
    try {
      String imeiData = await LoginRequest.initUniqueIdentifierState();
      Map<String, dynamic> body     = Map<String, dynamic>();
      body.putIfAbsent('cpf', () => accessCode.toString().padLeft(11,'0'));
      body.putIfAbsent('password', () => password);
      body.putIfAbsent('mobile_device', () => imeiData.toString());

      Map<String, String> headers  = Map<String, String>();
      headers.putIfAbsent('accept',       () => 'application/json');

      final response                  = await http.post(
                                          config.ENDPOINT_LOGIN,
                                          body: body,
                                          headers: headers,
                                        );
      Map<String, dynamic> dataWS     = jsonDecode(response.body);
      dataWS.putIfAbsent('status', () => response.statusCode);
      return dataWS;
    }
    catch(erro) {
      Map<String, dynamic> dataWS     = Map<String, dynamic>();
      dataWS.putIfAbsent('status', () => 404);
      return dataWS;
    }
  } // Future<Map<String, dynamic>> getLogin(Login login) { ... }

  static Future<String> initUniqueIdentifierState() async {
    String identifier;
    try {
      identifier = await UniqueIdentifier.serial;
    }
    catch(error) {
      identifier = 'ERROR404LOGINREQUEST';
    }

    return identifier;
  }
} // class LoginRequest { ... }