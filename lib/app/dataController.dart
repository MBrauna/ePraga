import 'package:epraga/allFiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataController {
  static Future<bool> getDatabaseData(BuildContext context, List<String> modules) async {
    try {
      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

      if(modules.contains('login')) {
        // Gera uma consulta ao banco de dados para coletar informações.
        List dataLogin  = await context.read<App>().database.query('login',
          limit: 1,
          distinct: true,
        );

        if(dataLogin.length <= 0) {
          context.read<App>().login = null;
        } // if(dataLogin.length <= 0) { ... }
        else {
          // Inicia o cadastro do login
          Login login;
          // Percorre na lista de dados do DB criando o primeiro registro.
          dataLogin.forEach((element) {
            // Monta as informações de login
            login = Login(
              id: element['id'],
              name: element['name'],
              identity: element['identity'],
              device: element['device'],
              email: element['email'],
              mobileAccess: true,
              token: element['token'],
              expiredLogin: DateTime.fromMillisecondsSinceEpoch(element['expired']),
              lastLogin: DateTime.fromMillisecondsSinceEpoch(element['last']),
            );
            // Salva no contexto
            context.read<App>().login = login;
          }); // dataLogin.forEach((element) { ... });
        } // else { ... }
      } // if(modules.contains('login')) { ... }

      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

      if(modules.contains('schudule')) {
        List dataSchudule = await context.read<App>().database.query('schudule',
          distinct: true,
        ); // List dataSchudule = await context.read<App>().database.query('schudule', distinct: true,);

        if(dataSchudule.length <= 0) {
          context.read<App>().listSchudule  = List<Schudule>();
        } // if(dataSchudule.length <= 0) { ... }
        else {
          List<Schudule> listSchudule  = List<Schudule>();
          dataSchudule.forEach((element) {
            Schudule tmpSchudule  = Schudule(
              id: element['id'],
              description: element['description'],
              idSubsidiary: element['id_subsidiary'],
              idResponsible: element['id_responsible'],
              lastAlt: element['last_alt'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(element['last_alt']),
              startDate: element['start_date'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(element['start_date']),
              endDate: element['end_date'] == null ? null : DateTime.fromMillisecondsSinceEpoch(element['end_date']),
              status: element['status'] == 1 ? true : false,
              createdAt: element['created_at'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(element['created_at']),
              updatedAt: element['updated_at'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(element['updated_at']),
            );

            // Adiciona a lista os dados coletados.
            listSchudule.add(tmpSchudule);
          }); // dataSchudule.forEach((element) { ... });

          // Seta na sessão os dados.
          context.read<App>().listSchudule  = listSchudule;
        } // else { ... }
      } // if(modules.contains('schudule')) { ... }

      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

      return true;
    } // try { ... }
    catch(erro) {
      print('---->');
      print(erro);
      print('---->');
      return false;
    } // catch(erro) { ... }
  } // static Future<bool> getDatabaseData(BuildContext context) async { ... }




  static Future<bool> setDatabaseData(BuildContext context, List<String> modules) async {
    try {

      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

      if(modules.contains('login')) {
        // Coleta o login do contexto
        Login login = context.read<App>().login;

        // Limpa a base de login para setar novos dados.
        await context.read<App>().database.delete('login');

        await context.read<App>().database.transaction((txn) async {
          await txn.rawInsert('insert into login(id, name, identity, email, device, token, last, expired) values(?,?,?,?,?,?,?,?)',[
            login.id,
            login.name,
            login.identity,
            login.email,
            login.device,
            login.token,
            login.lastLogin.millisecondsSinceEpoch,
            login.expiredLogin.millisecondsSinceEpoch,
          ]);
        }); // await context.read<App>().database.transaction((txn) async { ... }
      } // if(modules.contains('login')) { ... }

      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

      if(modules.contains('schudule')) {
        // Coleta os dados da lista de agendamentos
        List<Schudule> listSchudule = context.read<App>().listSchudule;

        // Limpa todos os dados do agendamento.
        await context.read<App>().database.delete('schudule');

        for (var i = 0; i < listSchudule.length; i++) {
          await context.read<App>().database.transaction((txn) async {
            await txn.rawInsert('insert into schudule(id, description, id_subsidiary, id_responsible, last_alt, start_date, end_date, status, created_at, updated_at) values(?,?,?,?,?,?,?,?,?,?)',
            [
              listSchudule.elementAt(i).id,
              listSchudule.elementAt(i).description,
              listSchudule.elementAt(i).idSubsidiary,
              listSchudule.elementAt(i).idResponsible,
              listSchudule.elementAt(i).lastAlt == null ? DateTime.now().millisecondsSinceEpoch : listSchudule.elementAt(i).lastAlt.millisecondsSinceEpoch,
              listSchudule.elementAt(i).startDate == null ? DateTime.now().millisecondsSinceEpoch : listSchudule.elementAt(i).startDate.millisecondsSinceEpoch,
              listSchudule.elementAt(i).endDate == null ? null : listSchudule.elementAt(i).endDate.millisecondsSinceEpoch,
              listSchudule.elementAt(i).status ? 1 : 0,
              listSchudule.elementAt(i).createdAt == null ? DateTime.now().millisecondsSinceEpoch : listSchudule.elementAt(i).createdAt.millisecondsSinceEpoch,
              listSchudule.elementAt(i).updatedAt == null ? DateTime.now().millisecondsSinceEpoch : listSchudule.elementAt(i).updatedAt.millisecondsSinceEpoch,
            ]
            );
          });
        }
      } // if(modules.contains('schudule')) { ... }

      return true;
    } // try { ... }
    catch(erro) {
      return false;
    } // catch(erro) { ... }
  } // static Future<bool> setDatabaseData(BuildContext context) { ... }
} // class ContextController { ... }