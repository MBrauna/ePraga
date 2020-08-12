import 'package:epraga/allFiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class SplashController {
  static Future getRoute(BuildContext context) async {

    try {
      // Acessa as preferências compartilhadas para coleta dos dados.
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      Database database = await EPragaDB.createDatabase();
      context.read<App>().database  = database;

      if(sharedPreferences.containsKey('lastLogin')) {
        if(sharedPreferences.getInt('dataLogin') >= DateTime.now().subtract(Duration(days: 2)).millisecondsSinceEpoch) {
          // Se já estiver logado e estiver tudo ok ...
          bool dataControllerResp = await DataController.getDatabaseData(context);

          if(dataControllerResp) {
            return;
          }
        } // if(sharedPreferences.getInt('dataLogin') >= DateTime.now().subtract(Duration(days: 2)).millisecondsSinceEpoch) { ... }
      } // if(sharedPreferences.containsKey('lastLogin')) { ... }

      return;
    }
    catch(erro) {
      // Envia uma mensagem de alerta
      Message(context).error('[Atenção]Não foi possível iniciar a aplicação! Verifique.');
      return;
    }
  } // Future getRoute(BuildContext context) async { ... }
} // class SplashController { ... }