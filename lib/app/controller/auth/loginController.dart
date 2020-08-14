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
        DataController.setDatabaseData(context);

        // Salva nas preferencias compartilhadas a data de expiração do Login
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setInt('dataLogin', DateTime.now().millisecondsSinceEpoch);

        // Redireciona para a página principal
        Navigator.pushReplacement(context, FadePageRoute(MainEpragaPage()));
      }
      else if(request['status'] == 401) {
        Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Dados informados são inválidos! Verifique.',)));
      }
      else if(request['status'] == 404) {
        Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Servidor não encontrado! Verifique.',)));
      }
      else if(request['status'] == 408) {
        Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Lentidão na rede identificada! Tente novamente.',)));
      }
      else if(request['status'] == 412) {
        Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Dados inválidos foram informados! Verifique.',)));
      }
      else if(request['status'] == 500) {
        Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Em manutenção! Aguarde.',)));
      }
    }
    catch(error) {
      print(error);
      return;
    }
  } // static Future getDecision(BuildContext context, String accessCode, String password) { ... }
} // class LoginController { ... }