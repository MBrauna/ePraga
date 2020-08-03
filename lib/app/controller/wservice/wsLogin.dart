import 'dart:convert';

import 'package:http/http.dart' as http;

import './../../../model/allModels.dart' show Access, Login;
import './../../../config.dart' as config;

class WsLogin {
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  Map<String, dynamic> _loginData;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  WsLogin() {
    this._loginData = Map<String, dynamic>();
  }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  Future<Map<String, dynamic>> getLogin(Login login) async {
    try {
      // Realiza a requisição e fica aguardando a resposta para prosseguimento
      final response = await http.get(config.ENDPOINT_LOGIN);
      Map<String, dynamic> dataWS = jsonDecode(response.body);
      // Acrescenta ao retorno o código de resposta.
      // Adiciona o código da resposta
      this._loginData['code'] = response.statusCode;

      if(response.statusCode == 200) {
        this._loginData['access'] = List<Access>();
        dataWS['access'].forEach((value) {
          this._loginData['access'].add(Access.fromJson(value));
        }); // dataWS['acesso'].forEach((key, value) { ... }
      } // if(response.statusCode == 200) { ... }
      else {
        this._loginData['error'] = dataWS['error'];
      }

      return this._loginData;
    } // try { ... }
    catch (error) {
      print(error);
      Map<String, dynamic> tmpError = Map<String, dynamic>();
      tmpError['code']  = 999;
      tmpError['error'] = 'Não foi possível realizar a requisição verifique.' + error.toString();
      return tmpError;
    } // catch(erro) { ... }
  } // Future<Map<String, dynamic>> getLogin(Login login) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
} // class WsLogin {
