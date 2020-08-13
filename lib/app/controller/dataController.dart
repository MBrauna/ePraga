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
    } // try { ... }
    catch(erro) {
      return false;
    } // catch(erro) { ... }
  } // static Future<bool> getDatabaseData(BuildContext context) async { ... }




  static Future<bool> setDatabaseData(BuildContext context) async {
    try {
      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
      // LOGIN - Coleta do contexto os dados de login e armazena (ou atualiza).
      Login login = context.read<App>().login;

      if(login != null && login.hash != null && login.hash.isNotEmpty && login.user != null && login.user.toString().isNotEmpty) {
        List counterLogin = await context.read<App>().database.rawQuery('select count(1) as counter from login');

        if(counterLogin.length > 0 && counterLogin[0].counter <= 0) {
          // Se existe dados de login, então limpa o login existente.
          // Para preencher novamente com os dados da sessão.
          await context.read<App>().database.delete('login');
        }

        await context.read<App>().database.transaction((txn) async {
          await txn.rawInsert('insert into login(access_code, password, name, hash, last_login) values(?,?,?,?,?)',[login.user, login.password, login.name, login.hash, login.lastLogin.millisecondsSinceEpoch]);
        }); // await context.read<App>().database.transaction((txn) async { ... }
      } // if(login == null && login.hash != null && login.hash.isNotEmpty && login.user != null && login.user.toString().isNotEmpty) { ... }
      else {
        Message(context).error('[ATENÇÃO] Não foi possível atualizar os dados de login! Verifique.',tempo: 45);
        return false;
      }
      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

      return true;
    } // try { ... }
    catch(erro) {
      print(erro);
      return false;
    } // catch(erro) { ... }
  } // static Future<bool> setDatabaseData(BuildContext context) { ... }
} // class ContextController { ... }