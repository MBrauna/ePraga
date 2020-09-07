import 'package:epraga/allFiles.dart';

class DataController {
  static Future<bool> getDatabaseData(BuildContext context, List<String> modules) async {

    try {
      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

      if(modules.contains('login')) {
        // Gera uma consulta ao banco de dados para coletar informações.
        List dataLogin  = await context.read<EPraga>().database.query('login',
          limit: 1,
          distinct: true,
        );

        if(dataLogin.length <= 0) {
          context.read<EPraga>().login = null;
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
            context.read<EPraga>().login = login;
          }); // dataLogin.forEach((element) { ... });
        } // else { ... }
      } // if(modules.contains('login')) { ... }

      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

      if(modules.contains('schudule')) {
        List dataSchudule = await context.read<EPraga>().database.query('schudule',
          distinct: true,
        ); // List dataSchudule = await context.read<App>().database.query('schudule', distinct: true,);

        if(dataSchudule.length <= 0) {
          context.read<ListData>().listSchudule  = List<Schudule>();
        } // if(dataSchudule.length <= 0) { ... }
        else {
          List<Schudule> listSchudule  = List<Schudule>();

          for (var i = 0; i < dataSchudule.length; i++) {
            List<SchuduleItem> schuduleItem = List<SchuduleItem>();
            List listDBItem = await context.read<EPraga>().database.query('schudule_item',
              orderBy: 'sequence asc',
              where: 'id_schudule = ?',
              whereArgs: [
                dataSchudule.elementAt(i)['id'],
              ],
              distinct: true,
            ); // List listDBItem = await context.read<EPraga>().database.query('schudule_item', distinct: true);

            // Monta os itens relacionados ao agendamento
            for(var j = 0; j < listDBItem.length;j++) {
              SchuduleItem tmpSchuduleItem  = SchuduleItem(
                id: listDBItem.elementAt(j)['id'],
                description: listDBItem.elementAt(j)['description'],
                accept: listDBItem.elementAt(j)['accept'] == 0 ? false : true,
                combat: listDBItem.elementAt(j)['combat'] == 0 ? false : true,
                idSchudule: listDBItem.elementAt(j)['id_schudule'],
                images: List<ImageBase64>(),
                lastAlt: DateTime.fromMillisecondsSinceEpoch(listDBItem.elementAt(j)['last_alt']),
                latitude: listDBItem.elementAt(j)['latitude'],
                longitude: listDBItem.elementAt(j)['longitude'],
                note: listDBItem.elementAt(j)['note'],
                qtdeImage: listDBItem.elementAt(j)['qtde_image'],
                sequence: listDBItem.elementAt(j)['sequence'],
                status: listDBItem.elementAt(j)['status'] == 0 ? false : true,
                visit: listDBItem.elementAt(j)['visit'] == 0 ? false : true,
              );

              schuduleItem.add(tmpSchuduleItem);
            } // for(var j = 0; j < listDBItem.length;j++) { ... }

            Schudule tmpSchudule  = Schudule(
              id: dataSchudule.elementAt(i)['id'],
              description: dataSchudule.elementAt(i)['description'],
              idSubsidiary: dataSchudule.elementAt(i)['id_subsidiary'],
              idResponsible: dataSchudule.elementAt(i)['id_responsible'],
              lastAlt: dataSchudule.elementAt(i)['last_alt'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(dataSchudule.elementAt(i)['last_alt']),
              startDate: dataSchudule.elementAt(i)['start_date'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(dataSchudule.elementAt(i)['start_date']),
              endDate: dataSchudule.elementAt(i)['end_date'] == null ? null : DateTime.fromMillisecondsSinceEpoch(dataSchudule.elementAt(i)['end_date']),
              status: dataSchudule.elementAt(i)['status'] == 1 ? true : false,
              createdAt: dataSchudule.elementAt(i)['created_at'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(dataSchudule.elementAt(i)['created_at']),
              updatedAt: dataSchudule.elementAt(i)['updated_at'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(dataSchudule.elementAt(i)['updated_at']),
              schuduleItem: List<SchuduleItem>(),
            );

            // Adiciona a lista os dados coletados.
            listSchudule.add(tmpSchudule);
          } // for (var i = 0; i < dataSchudule.length; i++) { ... }

          // Seta na sessão os dados.
          context.read<ListData>().listSchudule = listSchudule;
        } // else { ... }
      } // if(modules.contains('schudule')) { ... }

      if(modules.contains('subsidiary')) {
        List dataSubsidiary = await context.read<EPraga>().database.query('subsidiary',
          distinct: true,
        ); // List dataSubsidiary = await context.read<App>().database.query('schudule', distinct: true,);

        if(dataSubsidiary.length <= 0) {
          context.read<ListData>().listSubsidiary  = List<Subsidiary>();
        } // if(dataSubsidiary.length <= 0) { ... }
        else {
          List<Subsidiary> listSchudule  = List<Subsidiary>();

          for (var i = 0; i < dataSubsidiary.length; i++) {
            Subsidiary tmpSubsidiary  = Subsidiary(
              id: dataSubsidiary.elementAt(i)['id'],
              idCompany: dataSubsidiary.elementAt(i)['id'],
              latitude: num.parse(dataSubsidiary.elementAt(i)['latitude']),
              longitude: num.parse(dataSubsidiary.elementAt(i)['longitude']),
              address: dataSubsidiary.elementAt(i)['address'],
              description: dataSubsidiary.elementAt(i)['description'],
              name: dataSubsidiary.elementAt(i)['name'],
            );

            listSchudule.add(tmpSubsidiary);
          } // for (var i = 0; i < dataSubsidiary.length; i++) { ... }
        }
      }

      return true;
    } // try { ... }
    catch(erro, stacktrace) {
      print('---->');
      print(stacktrace);
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
        Login login = context.read<EPraga>().login;

        // Limpa a base de login para setar novos dados.
        await context.read<EPraga>().database.delete('login');

        await context.read<EPraga>().database.transaction((txn) async {
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
        List<Schudule> listSchudule = context.read<ListData>().listSchudule;

        // Limpa todos os dados do agendamento.
        await context.read<EPraga>().database.delete('schudule');
        await context.read<EPraga>().database.delete('schudule_item');

        for (var i = 0; i < listSchudule.length; i++) {
          await context.read<EPraga>().database.transaction((txn) async {
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

          for(var j = 0; j < listSchudule.elementAt(i).schuduleItem.length; j++) {
            await context.read<EPraga>().database.transaction((txn) async {
              await txn.rawInsert('insert into schudule_item(id, id_schudule, sequence, qtde_image, latitude, longitude, visit, combat, accept, status, note, description, last_alt) values(?,?,?,?,?,?,?,?,?,?,?,?,?)',
              [
                listSchudule.elementAt(i).schuduleItem.elementAt(j).id,
                listSchudule.elementAt(i).schuduleItem.elementAt(j).idSchudule,
                listSchudule.elementAt(i).schuduleItem.elementAt(j).sequence,
                listSchudule.elementAt(i).schuduleItem.elementAt(j).qtdeImage,
                listSchudule.elementAt(i).schuduleItem.elementAt(j).latitude.toString(),
                listSchudule.elementAt(i).schuduleItem.elementAt(j).longitude.toString(),
                listSchudule.elementAt(i).schuduleItem.elementAt(j).visit ? 1 : 0,
                listSchudule.elementAt(i).schuduleItem.elementAt(j).combat ? 1 : 0,
                listSchudule.elementAt(i).schuduleItem.elementAt(j).accept ? 1 : 0,
                listSchudule.elementAt(i).schuduleItem.elementAt(j).status ? 1 : 0,
                listSchudule.elementAt(i).schuduleItem.elementAt(j).note,
                listSchudule.elementAt(i).schuduleItem.elementAt(j).description,
                listSchudule.elementAt(i).schuduleItem.elementAt(j).lastAlt.millisecondsSinceEpoch,
              ]);
            }); // await context.read<EPraga>().database.transaction((txn) async { ... }
          } // for(var j = 0; j < listSchudule.elementAt(i).schuduleItem.length; j++) { ... }
        }
      } // if(modules.contains('schudule')) { ... }

      if(modules.contains('subsidiary')) {
        // Coleta os dados do agendamento
        List<Subsidiary> listSubsidiary = Provider.of<ListData>(context,listen: false).listSubsidiary;

        // Limpa todos os dados do agendamento.
        await Provider.of<EPraga>(context,listen: false).database.delete('subsidiary');

        for (var i = 0; i < listSubsidiary.length; i++) {
          await context.read<EPraga>().database.transaction((txn) async {
            await txn.rawInsert('insert into subsidiary(id, id_company, latitude, longitude, name, description, address) values(?,?,?,?,?,?,?)',
            [
              listSubsidiary.elementAt(i).id,
              listSubsidiary.elementAt(i).idCompany,
              listSubsidiary.elementAt(i).latitude,
              listSubsidiary.elementAt(i).longitude,
              listSubsidiary.elementAt(i).name,
              listSubsidiary.elementAt(i).description,
              listSubsidiary.elementAt(i).address,
            ]
            );
          });
        } // for (var i = 0; i < listSchudule.length; i++) { ... }
      } // if(modules.contains('subsidiary')) { ... }

      return true;
    } // try { ... }
    catch(erro, stacktrace) {
      print('-->> dados <<--');
      print(erro);
      print(stacktrace);
      print('-->> dados <<--');
      return false;
    } // catch(erro) { ... }
  } // static Future<bool> setDatabaseData(BuildContext context) { ... }
} // class ContextController { ... }