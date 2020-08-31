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
            tokenDate: element['token_date'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(element['token_date']),
          );
        });
        // Armazena os dados de login na sessão.
        context.read<App>().login = login;

        if(login.tokenDate.isBefore(DateTime.now())) {
          Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Sessão expirou! Refaça o login',)));
          return false;
        } // if(login.tokenDate.isBefore(DateTime.now())) { ... }
      } //  if(modules.contains('login')) { ... }

      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
      
      if(modules.contains('guide')) {
        // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
        // Coleta os dados de manuais e guias.
        List dataGuide = await context.read<App>().database.query('guide',orderBy: 'guide_date desc');
        List<Guide> guideList = List<Guide>();
        // Cria os dados do manual - Guia
        if(dataGuide.length > 0) {
          dataGuide.forEach((element) {
            Guide tmpGuide  = Guide(
              id: element['id'],
              title: element['title'],
              body: element['body'],
              guideDate: (element['guide_date'] == null) ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(element['guide_date']),
            );
            guideList.add(tmpGuide);
          });
        } // if(dataGuide.length > 0) { ... }

        // Armazena os dados de guias na sessão
        context.read<App>().guide = guideList;
      } //else if(modules.contains('guide')) { ... }

      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

      if(modules.contains('schudule')){
        List dataSchudule = await context.read<App>().database.query('schudule',orderBy: 'start_date asc');
        List<Schudule> schuduleList = List<Schudule>();
        print(dataSchudule);
        if(dataSchudule.length > 0) {
          dataSchudule.forEach((element) {
            Schudule schudule = Schudule(
              id: element['id'],
              description: element['description'],
              latitude: num.parse(element['latitude']),
              longitude: num.parse(element['longitude']),
              startDate: element['start_date'] == null ? null : DateTime.fromMillisecondsSinceEpoch(element['start_date']),
              dueDate: element['due_date'] == null ? null : DateTime.fromMillisecondsSinceEpoch(element['due_date']),
              editDate: element['edit_date'] == null ? null : DateTime.fromMillisecondsSinceEpoch(element['edit_date']),
              locationDescription: element['local_desc'],
              locationName: element['local_name'],
              schuduleItemList: List(),
            );
            schuduleList.add(schudule);
          });
        } // if(dataSchudule.length > 0) { .. }

        context.read<App>().schudule  = schuduleList;
      } // if(modules.contains('schudule')){ ... }
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

          print(login.tokenDate.toString() + ' -----  ' + login.lastLogin.toString());

          await context.read<App>().database.transaction((txn) async {
            await txn.rawInsert('insert into login(access_code, password, name, hash, last_login, token_date) values(?,?,?,?,?,?)',[login.user, login.password, login.name, login.hash, login.lastLogin.millisecondsSinceEpoch, login.tokenDate.millisecondsSinceEpoch]);
          }); // await context.read<App>().database.transaction((txn) async { ... }
        } // if(login == null && login.hash != null && login.hash.isNotEmpty && login.user != null && login.user.toString().isNotEmpty) { ... }
        else {
          Message(context).error('[ATENÇÃO] Não foi possível atualizar os dados de login! Verifique.',tempo: 5);
          return false;
        }
        // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
      } // if(modules.contains('login')) { ... }

      if(modules.contains('guide')) {
        // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
        // GUIDE - Coleta do contexto os dados de guias e manuais e armazena.
        List<Guide> guideList = context.read<App>().guide;
        await context.read<App>().database.delete('guide');


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

      if(modules.contains('schudule')) {
        // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
        // Dados de agendamento
        List<Schudule> schuduleList = context.read<App>().schudule;

        for (var i = 0; i < schuduleList.length; i++) {
          List counterSchudule = await context.read<App>().database.rawQuery('select id, edit_date from schudule where id = ?',[schuduleList.elementAt(i).id]);

          if(counterSchudule.length <= 0) {
            // Se não existir realizar o insert
            await context.read<App>().database.transaction((txn) async {
              await txn.rawInsert('insert into schudule(id, description, latitude, longitude, start_date, due_date, edit_date, location_name, location_description) values(?,?,?,?,?,?,?,?,?)',
              [
                schuduleList.elementAt(i).id,
                schuduleList.elementAt(i).description,
                schuduleList.elementAt(i).latitude.toString(),
                schuduleList.elementAt(i).longitude.toString(),
                schuduleList.elementAt(i).startDate == null ? DateTime.now().millisecondsSinceEpoch : schuduleList.elementAt(i).startDate.millisecondsSinceEpoch,
                schuduleList.elementAt(i).dueDate == null ? null : schuduleList.elementAt(i).dueDate.millisecondsSinceEpoch,
                schuduleList.elementAt(i).editDate == null ? DateTime.now().millisecondsSinceEpoch : schuduleList.elementAt(i).editDate.millisecondsSinceEpoch,
                schuduleList.elementAt(i).locationName,
                schuduleList.elementAt(i).locationDesc
              ]
              );
            });
          }
          else {
            // Se existir realiza update
            for(var j = 0; j < counterSchudule.length; j++) {
              await context.read<App>().database.transaction((txn) async {
                await txn.rawInsert('update schudule set description = ?, latitude = ?, longitude = ?, start_date = ?, due_date = ?, edit_date = ? where id = ? and edit_date < ?',
                [
                  schuduleList.elementAt(i).description,
                  schuduleList.elementAt(i).latitude.toString(),
                  schuduleList.elementAt(i).longitude.toString(),
                  schuduleList.elementAt(i).startDate == null ? DateTime.now().millisecondsSinceEpoch : schuduleList.elementAt(i).startDate.millisecondsSinceEpoch,
                  schuduleList.elementAt(i).dueDate == null ? null : schuduleList.elementAt(i).dueDate.millisecondsSinceEpoch,
                  schuduleList.elementAt(i).editDate == null ? DateTime.now().millisecondsSinceEpoch : schuduleList.elementAt(i).editDate.millisecondsSinceEpoch,
                  counterSchudule.elementAt(j)['id'],
                  schuduleList.elementAt(i).editDate.millisecondsSinceEpoch
                ]
                );
              });
            } // for(var j = 0; j < counterSchudule.length; j++) { ... }
          } // else { ... }
        } // for (var i = 0; i < schuduleList.length; i++) { ... }
        // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
      } // if(modules.contains('schudule')) { ... }

      return true;
    } // try { ... }
    catch(erro) {
      return false;
    } // catch(erro) { ... }
  } // static Future<bool> setDatabaseData(BuildContext context) { ... }
} // class ContextController { ... }