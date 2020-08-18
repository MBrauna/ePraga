import 'package:epraga/allFiles.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataController {
  static Future<bool> getDatabaseData(BuildContext context, List<String> modules) async {
    try {
      if(modules.contains('login')) {
        // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
        // Gera uma consulta ao banco de dados para a tabela de login
        List dataLogin  = await context.read<App>().database.query('login',limit: 1);
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
      } //  if(modules.contains('login')) { ... }
      else if(modules.contains('guide')) {
        // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
        // Coleta os dados de manuais e guias.
        List dataGuide = await context.read<App>().database.query('guide',orderBy: 'guide_date desc');
        List<Guide> guideList;
        // Cria os dados do manual - Guia
        dataGuide.forEach((element) {
          Guide tmpGuide  = Guide(
            id: element['id'],
            title: element['title'],
            body: element['body'],
            guideDate: (element['guide_date'] == null) ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(element['guide_date']),
          );

          guideList.add(tmpGuide);
        });
        // Armazena os dados de guias na sessão
        context.read<App>().guide = guideList;
      } //else if(modules.contains('guide')) { ... }

      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //


      return true;
    } // try { ... }
    catch(erro) {
      print(erro);
      return false;
    } // catch(erro) { ... }
  } // static Future<bool> getDatabaseData(BuildContext context) async { ... }




  static Future<bool> setDatabaseData(BuildContext context, List<String> modules) async {
    try {
      if(modules.contains('login')) {
        // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
        // LOGIN - Coleta do contexto os dados de login e armazena (ou atualiza).
        Login login = context.read<App>().login;

        if(login != null && login.hash != null && login.hash.isNotEmpty && login.user != null && login.user.toString().isNotEmpty) {
          List counterLogin = await context.read<App>().database.rawQuery('select count(1) as counter from login');

          if(counterLogin.length > 0) {
            // Se existe dados de login, então limpa o login existente.
            // Para preencher novamente com os dados da sessão.
            await context.read<App>().database.delete('login');
          } // if(counterLogin.length > 0) { ... }

          await context.read<App>().database.transaction((txn) async {
            await txn.rawInsert('insert into login(access_code, password, name, hash, last_login) values(?,?,?,?,?)',[login.user, login.password, login.name, login.hash, login.lastLogin.millisecondsSinceEpoch]);
          }); // await context.read<App>().database.transaction((txn) async { ... }
        } // if(login == null && login.hash != null && login.hash.isNotEmpty && login.user != null && login.user.toString().isNotEmpty) { ... }
        else {
          Message(context).error('[ATENÇÃO] Não foi possível atualizar os dados de login! Verifique.',tempo: 5);
          return false;
        }

        // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
      } // if(modules.contains('login')) { ... }
      else if(modules.contains('guide')) {
        // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
        // GUIDE - Coleta do contexto os dados de guias e manuais e armazena.
        List<Guide> guideList = context.read<App>().guide;
        await context.read<App>().database.delete('login');


        // Usa-se for e não forEach devido o await, deve ser sincrono.
        for (var i = 0; i < guideList.length; i++) {
          // Primeira etapa - Verifica se o elemento é realmente existente.
          List counterGuide = await context.read<App>().database.rawQuery('select count(1) as counter from guide where id = ?',[guideList.elementAt(i).id]);

          if(counterGuide.length > 0) {
            for (var elements in counterGuide) {
              if(elements['counter'] <= 0) {
                await context.read<App>().database.transaction((txn) async {
                  await txn.rawInsert('insert into guide(id, title, body, guide_date) values(?,?,?,?)',[guideList.elementAt(i).id, guideList.elementAt(i).title, guideList.elementAt(i).body, guideList.elementAt(i).createdAt.millisecondsSinceEpoch]);
                });
              } // if(elements['counter'] <= 0) { ... }
              else {
                // Nunca irá cair aqui, mas se a regra mudar, estará preparado.
                await context.read<App>().database.transaction((txn) async {
                  await txn.rawUpdate('update guide set title = ?, body = ?, guide_date = ? where id=?',[guideList.elementAt(i).title, guideList.elementAt(i).body, guideList.elementAt(i).createdAt.millisecondsSinceEpoch, guideList.elementAt(i).id]);
                });
              } // else { ... }
            } // for (var j in counterGuide) { ... }
          } // if(counterGuide.length > 0) { ... }
        } // for (var i = 0; i < guideList.length; i++) { ... }
        
        // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
      } // else if(modules.contains('guide')) { ... }

      

      return true;
    } // try { ... }
    catch(erro) {
      return false;
    } // catch(erro) { ... }
  } // static Future<bool> setDatabaseData(BuildContext context) { ... }
} // class ContextController { ... }