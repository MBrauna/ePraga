import 'dart:convert';

import 'package:epraga/allFiles.dart';
import 'package:http/http.dart' as http;

class RequestController {
  static Future<bool> requestSchudule(BuildContext context) async {
    try {
      Login login = context.read<EPraga>().login;
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
            List<Schudule> listSchudule = List<Schudule>();

            dataResponse['schudule'].forEach((elementSchudule){
              Schudule tmpSchudule  = Schudule.fromJson(elementSchudule);
              listSchudule.add(tmpSchudule);
            }); // dataResponse['schudule'].forEach((elementSchudule){ ... });

            // Verifica o que já tem salvo em sessão para preenchimento.
            listSchudule.forEach((element) {
              List<Schudule> listTmp = Provider.of<ListData>(context, listen: false).listSchudule.where((elementSchudule) => elementSchudule.id == element.id).toList();
              
              // Se não existir irá adicionar a lista
              if(listTmp.length <= 0) {
                Provider.of<ListData>(context,listen: false).listSchudule.add(element);
              }
              else {
                listTmp.forEach((elementTmp) {
                  if(elementTmp.lastAlt.millisecondsSinceEpoch <= element.lastAlt.millisecondsSinceEpoch) {
                    // Remove o existente ... 
                    Provider.of<ListData>(context, listen: false).listSchudule.remove(elementTmp);
                    // adiciona o novo
                    Provider.of<ListData>(context, listen: false).listSchudule.add(element);
                  }
                  else {
                    // Se ele for mais atual que o recebido ... mantém o atual.
                  }
                }); // listTmp.forEach((elementTmp) { ... }
              }
            });

            // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
            List<Subsidiary> listSubsidiary = List<Subsidiary>();

            dataResponse['subsidiary'].forEach((elementSubsidiary){
              Subsidiary tmpSubsidiary = Subsidiary.fromJson(elementSubsidiary);
              listSubsidiary.add(tmpSubsidiary);
            }); // dataResponse['subsidiary'].forEach((elementSubsidiary){ ... }

            Provider.of<ListData>(context,listen: false).listSubsidiary = listSubsidiary;

            // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
          } // else { ... }

          break;
        default:
          Message(context).error(dataResponse['error']['message']);
      }

      await DataController.setDatabaseData(context, ['schudule','subsidiary']);
      return true;
    }
    catch(erro){
      print('---->');
      print(erro);
      print('---->');
      return false;
    }
  } // static Future<bool> requestSchudule(BuildContext context) async { ... }
}