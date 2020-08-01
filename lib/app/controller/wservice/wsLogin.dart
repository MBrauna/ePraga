import 'dart:convert';

import 'package:http/http.dart' as http;

import './../../../model/allModels.dart' show Access, Login;
import './../../../config.dart' as config;

class WsLogin {
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  List<Access> _loginData;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  WsLogin() {
    this._loginData = null;
  }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  Future<List<Access>> getLogin(Login login) async {
    try {
      // Realiza a requisição e fica aguardando a resposta para prosseguimento
      final response = await http.get(config.ENDPOINT_LOGIN);
      Map<String, dynamic> dataWS = jsonDecode(response.body);
      // Acrescenta ao retorno o código de resposta.

      if (response.statusCode == 200) {
        dataWS['acesso'].forEach((key, value) {
          //this._loginData.add(Access.fromJson(jsonEncode(value)));
          print('[' + key + '] -' + value);
        }); // dataWS['acesso'].forEach((key, value) { ... }
      } // if(response.statusCode == 200) { ... }

      return List<Access>();
    } // try { ... }
    catch (erro) {
      return List<Access>();
    } // catch(erro) { ... }
  } // Future<Map<String, dynamic>> getLogin(Login login) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
} // class WsLogin {
