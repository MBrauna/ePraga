import 'dart:convert';
import 'package:http/http.dart' as http;

import './../../../config/config.dart' as config;
import 'package:epraga/allFiles.dart';

class SchuduleRequest {
  static Future<Map<String, dynamic>> getSchudule(String hash) async{ 
    try {
      // Realiza a requisição e fica aguardando a resposta para prosseguimento
      //final request                   = {'accessCode' : accessCode,'password' : password,};
      final response                  = await http.get(config.ENDPOINT_SCHUDULE);
      Map<String, dynamic> dataWS     = jsonDecode(response.body);
      dataWS.putIfAbsent('status', () => response.statusCode);
      return dataWS;
    } // try { ... }
    catch(error){
      Map<String, dynamic> dataWS     = Map<String, dynamic>();
      dataWS.putIfAbsent('status', () => 404);
      return dataWS;
    } // catch(error){ ... }
  } // static Future<Map<String, dynamic>> getSchudule({models.Login data}) async { ... }
}