import 'dart:convert';

import 'package:http/http.dart' as http;
import './../../config.dart' as config;

class LoginRequest {
  static Future<Map<String, dynamic>> getLogin() async{
    try {
      // Realiza a requisição e fica aguardando a resposta para prosseguimento
      final response                  = await http.get(config.ENDPOINT_LOGIN);
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