import 'package:epraga/allFiles.dart';
import 'package:epraga/resources/page/mainEPragaPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  static Future getDecision(BuildContext context, String accessCode, String password) async {
    try {
      Map<String, dynamic> request = await LoginRequest.getLogin(accessCode: int.parse(accessCode), password: password);

      if(request['status'] == 200) {
        // Salva no banco de dados a informação
        Login login  = Login.fromJson(request,password: password);

        // Salva na sessão os dados do usuário
        context.read<App>().login  = login;
        bool execController = await DataController.setDatabaseData(context,['login']);

        if(!execController) {
          Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Ocorreu um erro ao realizar o login! Verifique.',)));
          return;  
        } // if(!execController) { ... }

        // Salva nas preferencias compartilhadas a data de expiração do Login
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setInt('lastLogin', DateTime.now().add(Duration(days: 2)).millisecondsSinceEpoch);

        // Redireciona para a página principal
        Navigator.pushReplacement(context, FadePageRoute(MainEpragaPage()));
        return;
      } // if(request['status'] == 200) { ... }
      else if(request['status'] == 401) {
        Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Dados informados são inválidos! Verifique.',)));
        return;
      } // else if(request['status'] == 401) { ... }
      else if(request['status'] == 404) {
        Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Servidor não encontrado! Verifique.',)));
        return;
      } // else if(request['status'] == 404) { ... }
      else if(request['status'] == 408) {
        Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Lentidão na rede identificada! Tente novamente.',)));
        return;
      } // else if(request['status'] == 408) { ... }
      else if(request['status'] == 412) {
        Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Dados inválidos foram informados! Verifique.',)));
        return;
      } // else if(request['status'] == 412) { ... }
      else if(request['status'] == 500) {
        Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Em manutenção! Aguarde.',)));
        return;
      } // else if(request['status'] == 500) { ... }
      else {
        Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Não foi possível realizar o login no momento! Aguarde.',)));
        return;
      } // else { ... }
    }
    catch(error) {
      Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Erro grave ao realizar o login! Aguarde.',)));
      return;
    }
  } // static Future getDecision(BuildContext context, String accessCode, String password) { ... }
} // class LoginController { ... }