import 'dart:convert';

import 'package:http/http.dart' as http;
import './../../../config/config.dart' as config;

class GuideRequest {
  static Future<Map<String, dynamic>> getGuide(String hash) async{
    try {
      // Realiza a requisição e fica aguardando a resposta para prosseguimento
      //final request                   = {'accessCode' : accessCode,'password' : password,};
      final response                  = await http.post(config.ENDPOINT_GUIDE);
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
} // class LoginRequest { ... }