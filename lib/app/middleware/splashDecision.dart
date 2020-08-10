import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import './../util/fadePageRoute.dart';
import './../exception/ePragaException.dart';
import './../../database/ePragaDB.dart';
import './../../model/allModels.dart' as models;
import './../../resources/allPages.dart' as pages;

class SplashDecision {
  Future getRoute(BuildContext context) async{
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // Inicializa a leitura ao Database --> Se necessário cria as tabelas.
      Database database = await EPragaDB().createDatabase();
      context.read<models.App>().database = database;

      if(sharedPreferences.containsKey('dataLogin')) {
        if(sharedPreferences.getInt('dataLogin') >= DateTime.now().subtract(Duration(days: 2)).millisecondsSinceEpoch) {
          // Se chegou aqui então possui login válido! Carrega ao contexto as tabelas.
          models.Login login  = await models.Login.getDB(database);
          context.read<models.App>().login  = login;
          print(login);

          Navigator.pushReplacement(context, FadePageRoute(pages.MainEpraga()));
          return;
        } // if(sharedPreferences.getInt('dataLogin') <= DateTime.now().millisecondsSinceEpoch) { ... }
        else {
          sharedPreferences.remove('dataLogin');
        }
      } // if(sharedPreferences.containsKey('dataLogin')) { ... }

      Navigator.pushReplacement(context, FadePageRoute(pages.Login()));
      return;
    }
    catch(erro) {
      throw new EPragaException(
        error: erro,
        message: 'Não foi possível executar o sistema de decisão! Verifique.',
        origin: this.runtimeType.toString(),
      );
    }
  } // Future<FadePageRoute> getRoute() async { ... }
} // class SplashDecision { ... }