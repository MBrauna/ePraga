import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import './../wscom/schuduleRequest.dart';
import './../util/verifyNetwork.dart';
import './../../model/allModels.dart' as models;
import './../util/message.dart';

class SchuduleController {
  static Future getDecision(BuildContext context) async {
    bool verifyNetwork =  await VerifyNetwork().verify();
    Database  database  = context.read<models.App>().database;

    if(verifyNetwork) {
      final     request   = await SchuduleRequest.getSchudule();
      // Cria uma lista vazia para atualização
      List<models.SchuduleEpraga> schudule = List<models.SchuduleEpraga>();

      if(request['status'] == 200) {
        // Realiza um loop para coletar armazenar os dados
        request['schudule'].forEach((element){
          schudule.add(models.SchuduleEpraga.fromJson(element));
        });
        // Salva os dados no DB
        schudule.forEach((element) {
          models.SchuduleEpraga.setDB(database, element);
        });
        
        Message(context).info('Sucesso! Dados atualizados.');
      }
      else if(request['status'] == 401) {
        Message(context).error('Dados informados são inválidos! Verifique.');
      }
      else if(request['status'] == 404) {
        Message(context).error('Servidor não encontrado! Verifique.');
      }
      else if(request['status'] == 408) {
        Message(context).error('Atenção, lentidão na rede! Verifique.');
      }
      else if(request['status'] == 412) {
        Message(context).error('Dados inválidos foram informados! Verifique.');
      }
      else if(request['status'] == 500) {
        Message(context).error('Servidores em manutenção! Aguarde.');
      }

      // Salva na sessão os dados do agendamento
      context.read<models.App>().schudule = await models.SchuduleEpraga.getDB(database);
    }
    else {
      // Salva na sessão os dados do agendamento
      context.read<models.App>().schudule = await models.SchuduleEpraga.getDB(database);
    }
  } // static Future getDecision() async { ... }
} // class SchuduleController { ... }