import 'dart:async';

import 'package:epraga/allFiles.dart';
import 'package:epraga/resources/page/mainEPragaPage.dart';
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
        if(DateTime.now().millisecondsSinceEpoch <= sharedPreferences.getInt('lastLogin')) {
          // Se já estiver logado e estiver tudo ok ...
          bool dataControllerResp = await DataController.getDatabaseData(context,['login','guide']);

          if(dataControllerResp) {
            Navigator.pushReplacement(context, FadePageRoute(MainEpragaPage()));
            return;
          }
        } // if(sharedPreferences.getInt('lastLogin') >= DateTime.now().subtract(Duration(days: 2)).millisecondsSinceEpoch) { ... }
      } // if(sharedPreferences.containsKey('lastLogin')) { ... }

      bool verifyNetwork = false;
      while(!verifyNetwork) {
        verifyNetwork = await VerifyNetwork().verify();
        
        if(verifyNetwork) {
          Navigator.pushReplacement(context, FadePageRoute(LoginPage()));
          return;
        }
        else {
          await Future.delayed(Duration(seconds: 5),(){
            Message(context).error('[ATENÇÃO] - SISTEMA OFFLINE\nA operação a seguir necessita de rede! Verifique.\nTentaremos novamente em 5 segundos',tempo: 3);
          });
        }
      } // while(!verifyNetwork) { ... }

    }
    catch(erro) {
      // Envia uma mensagem de alerta
      Message(context).error('[Atenção]Não foi possível iniciar a aplicação! Verifique.');
      return;
    }
  } // Future getRoute(BuildContext context) async { ... }
} // class SplashController { ... }