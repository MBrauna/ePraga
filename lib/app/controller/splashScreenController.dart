import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';
import 'package:epraga/allFiles.dart';

class SplashScreenController {
  static Future<bool> permissions() async {
    final PermissionHandler permission = PermissionHandler();

    var result = await permission.requestPermissions([
      PermissionGroup.camera,
      PermissionGroup.location,
      PermissionGroup.locationAlways,
      PermissionGroup.locationWhenInUse,
      PermissionGroup.storage,
      PermissionGroup.phone,
    ]);

    if((result[PermissionGroup.camera] != PermissionStatus.granted) ||
      (result[PermissionGroup.location] != PermissionStatus.granted) ||
      (result[PermissionGroup.locationAlways] != PermissionStatus.granted) ||
      (result[PermissionGroup.locationWhenInUse] != PermissionStatus.granted) ||
      (result[PermissionGroup.storage] != PermissionStatus.granted) ||
      (result[PermissionGroup.phone] != PermissionStatus.granted)) {
      return false;
    } // if((result[PermissionGroup.camera] != PermissionStatus.granted) || (result[PermissionGroup.location] != PermissionStatus.granted) || (result[PermissionGroup.locationAlways] != PermissionStatus.granted) || (result[PermissionGroup.locationWhenInUse] != PermissionStatus.granted) || (result[PermissionGroup.mediaLibrary] != PermissionStatus.granted) || (result[PermissionGroup.photos] != PermissionStatus.granted) ||  (result[PermissionGroup.storage] != PermissionStatus.granted)) { ... }

    return true;
  } // static Future permissions() async { ... }

  static Future getRoute(BuildContext context) async {
    try {
      // Coleta os dados do database, e caso não exista, cria.
      Database database             = await EPragaDB.createDatabase();
      context.read<App>().database  = database;

      // Coleta do banco de dados as informações previamente cadastradas
      bool dataDB = await DataController.getDatabaseData(context, ['login','schudule']);
      Login login = context.read<App>().login;

      if(dataDB) {
        if((login == null) || (login.expiredLogin.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch)) {
          // Envia para a tela de login
          Navigator.pushReplacement(context, FadePageRoute(LoginPage()));
          return;
        } // if(login == null || login.expiredLogin <= DateTime.now().millisecondsSinceEpoch) { ... }
        else {

          // Envia para a tela principal
          Navigator.pushReplacement(context, FadePageRoute(MainPage()));
          return;
        } // else { ... }
      } // if(dataDB) { ... }
      else {
        Message(context).error('Não foi possível iniciar a aplicação! Banco de dados falhou.');
        return;
      } // else { ... }

    } // try { ... }
    catch(erro) {
      print(erro);
      Message(context).error('Não foi possível iniciar a aplicação! Erro fatal');
      return;
    } // catch(erro) { ... }
  } // static Future getRoute(BuildContext context) async { ... }
}