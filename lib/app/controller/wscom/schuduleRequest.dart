import 'dart:convert';
import 'package:http/http.dart' as http;

import './../../../config/config.dart' as config;

class SchuduleRequest {
  static Future<Map<String, dynamic>> getSchudule(String hash) async{ 
    try {
      Map<String, dynamic> body     = Map<String, dynamic>();
      Map<String, String> headers  = Map<String, String>();
      headers.putIfAbsent('accept',       () => 'application/json');
      headers.putIfAbsent('authorization',() => 'Bearer ' + hash);

      final response                  = await http.post(
                                          config.ENDPOINT_SCHUDULE,
                                          body: body,
                                          headers: headers,
                                        );
      Map<String, dynamic> dataWS     = Map<String, dynamic>();
      dataWS.putIfAbsent('schudule', () => jsonDecode(response.body));
      dataWS.putIfAbsent('status', () => response.statusCode);
      return dataWS;
    }
    catch(erro) {
      Map<String, dynamic> dataWS     = Map<String, dynamic>();
      dataWS.putIfAbsent('schudule', () => List());
      dataWS.putIfAbsent('status', () => 404);
      return dataWS;
    }
  } // static Future<Map<String, dynamic>> getSchudule({models.Login data}) async { ... }
}