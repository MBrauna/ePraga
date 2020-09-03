import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:epraga/allFiles.dart';
import 'package:http/http.dart' as http;

class SchuduleController {
  static Future<bool> requestSchudule(BuildContext context) async {
    try {
      Login login = context.read<App>().login;
      if(login == null || login.expiredLogin.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch || login.token.trim().isEmpty) {
        Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Sua sessão expirou! Verifique.',)));
        return false;
      } // if(login == null || login.expiredLogin.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch || login.token.trim().isEmpty) { ... }

      Map<String, dynamic> body     = Map<String, dynamic>();

      Map<String, String> headers  = Map<String, String>();
      headers.putIfAbsent('accept',         () => 'application/json');
      headers.putIfAbsent('Authorization',  () => 'Bearer ' + login.token.trim());
      // Declaração de variáveis

      // Realiza a requisição - Comunica com o servidor.
      final response  = await http.post(
        ENDPOINT_SCHUDULE,
        body: body,
        headers: headers,
      );
      // Realiza a requisição - Comunica com o servidor.

      Map<String, dynamic> dataResponse = jsonDecode(response.body);

      switch (response.statusCode) {
            case 200:
              // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
              if(dataResponse['schudule'].length <= 0) {
                Message(context).info('Nenhuma tarefa disponível!');
              } // if(!dataResponse['mobile_access']) { ... }
              else {
                // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
                List<Schudule> dataSchudule = List<Schudule>();
                List<SchuduleItem> dataSchuduleItem = List<SchuduleItem>();
                List<Subsidiary> dataSubsidiary = List<Subsidiary>();

                // Gera os schudules para o sistema.
                dataResponse['schudule'].forEach((element) {
                  Schudule tmpSchudule          = Schudule.fromJson(element);
                  Subsidiary tmpSubsidiary      = Subsidiary.fromJson(element['subsidiary']);

                  // Adiciona o registro a lista
                  dataSchudule.add(tmpSchudule);
                  dataSubsidiary.add(tmpSubsidiary);

                  if(element['item'].length > 0) {
                    element['item'].forEach((elementItem){
                      SchuduleItem tmpSchuduleItem = SchuduleItem.fromJson(elementItem);
                      dataSchuduleItem.add(tmpSchuduleItem);
                    });
                  } // if(element['item'].length > 0) { ... }
                }); // dataResponse['schudule'].forEach((element) { ... }
                // Gera os schudules para o sistema.

                // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

                /*dataSchudule.forEach((element) {
                  List<Schudule> qtdeReg  = context.read<App>().listSchudule.where((valueContext)=> valueContext.id == element.id).toList();

                  if(qtdeReg.length <= 0) {
                    // Caso não exista registros -- INSERE
                    context.read<App>().listSchudule.add(element);
                  } // if(qtdeReg.length <= 0) { ... }
                  else if(qtdeReg.length == 1){
                    // Existe registros -- Verifica qual o mais recente
                    context.read<App>().listSchudule.where((valueContext)=> ((valueContext.id == element.id) && (valueContext.lastAlt.isBefore(element.lastAlt)))).toList().forEach((elementRemove) {
                      context.read<App>().listSchudule.remove(elementRemove);
                    });
                    context.read<App>().listSchudule.add(element);
                  } // else { ... }
                }); // dataSchudule.forEach((element) { ... }*/
                context.read<App>().listSchudule  = dataSchudule;

                dataSubsidiary.forEach((element) {
                  List<Subsidiary> qtdeReg  = context.read<App>().listSubsidiary.where((valueContext) => valueContext.id == element.id).toList();

                  if(qtdeReg.length <= 0) {
                    context.read<App>().listSubsidiary.add(element);
                  } // if(qtdeReg.length <= 0) { ... }
                }); // dataSubsidiary.forEach((element) { ... });

                dataSchuduleItem.forEach((element) {
                  List<SchuduleItem> qtdeReg  = context.read<App>().listSchuduleItem.where((valueContext) => valueContext.id == element.id).toList();

                  if(qtdeReg.length <= 0) {
                    context.read<App>().listSchuduleItem.add(element);
                  } // if(qtdeReg.length <= 0) { ... }
                }); // dataSubsidiary.forEach((element) { ... });

                DataController.setDatabaseData(context, ['schudule','subsidiary','schuduleItem']);
                Message(context).info('Dados atualizados!');

                // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
              } // else { ... }

              break;
            default:
              Message(context).error(dataResponse['error']['message']);
          }

      return true;
    }
    catch(erro, stacktrace) {
      print('><><><><><><');
      print(erro);
      print(stacktrace);
      print('><><><><><><');
      return false;
    }
  } // static Future<bool> requestSchudule(BuildContext context) { ... }
} // class SchuduleController { ... }