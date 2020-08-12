import 'package:epraga/allFiles.dart';
import 'package:epraga/models/auth/login.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataController {
  static Future<bool> getDatabaseData(BuildContext context) async {
    try {
      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
      // Gera uma consulta ao banco de dados para a tabela de login
      List dataLogin  = await context.watch<App>().database.query('login',limit: 1);
      // Cria os dados de login
      Login login;
      dataLogin.forEach((element) {
        login = Login(
          accessCode: element['access_code'],
          password: element['password'],
          hash: element['hash'],
          name: element['name'],
          lastLogin: element['last_login'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(element['last_login']),
        );
      });
      // Armazena os dados de login na sessão.
      context.read<App>().login = login;
      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //


      return true;
    }
    catch(erro) {
      return false;
    }
  }
} // class ContextController { ... }