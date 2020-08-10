import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';

import './../wscom/loginRequest.dart';
import './../util/fadePageRoute.dart';
import './../../resources/allPages.dart' as pages;
import './../../model/allModels.dart' as models;

class LoginRoomController {
  static Future getDecision(BuildContext context, String accessCode, String password) async {
    Map<String, dynamic> request = await LoginRequest.getLogin(accessCode: int.parse(accessCode), password: password);
    Database database = context.read<models.App>().database;

    if(request['status'] == 200) {
      // Salva no banco de dados a informação
      models.Login login  = models.Login.fromJson(request,password: password);
      await models.Login.setDB(database, login);

      // Salva na sessão os dados do usuário
      context.read<models.App>().login  = login;
      // Salva nas preferencias compartilhadas a data de expiração do Login
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setInt('dataLogin', DateTime.now().millisecondsSinceEpoch);
      // Redireciona para a página principal
      Navigator.pushReplacement(context, FadePageRoute(pages.MainEpraga()));
    }
    else if(request['status'] == 401) {
      Navigator.pushReplacement(context, FadePageRoute(pages.Login(message: 'Dados informados são inválidos! Verifique.',)));
    }
    else if(request['status'] == 404) {
      Navigator.pushReplacement(context, FadePageRoute(pages.Login(message: 'Servidor não encontrado! Verifique.',)));
    }
    else if(request['status'] == 408) {
      Navigator.pushReplacement(context, FadePageRoute(pages.Login(message: 'Lentidão na rede identificada! Tente novamente.',)));
    }
    else if(request['status'] == 412) {
      Navigator.pushReplacement(context, FadePageRoute(pages.Login(message: 'Dados inválidos foram informados! Verifique.',)));
    }
    else if(request['status'] == 500) {
      Navigator.pushReplacement(context, FadePageRoute(pages.Login(message: 'Em manutenção! Aguarde.',)));
    }
  } // static Future<String> getDecision(BuildContext context) { ... }
} // class LoginRoomController { ... }