import 'dart:convert';

import 'package:epraga/allFiles.dart';
import 'package:http/http.dart' as http;

class LoginController {
  static Future<String> initUniqueIdentifierState() async {
    String identifier = 'IMEIDATA';

    return identifier;
  } // static Future<String> initUniqueIdentifierState() async { ... }

  static Future requestLogin(BuildContext context, String user, String password) async {
    bool network  = await VerifyNetwork().verify();

    if(!network) {
      Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Você está operando em modo offline!\nEsta etapa exige rede.',)));
      return;
    } // if(!network) { ... }
    else {
      try {
        if(ENDPOINT_LOGIN == null) {
          Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Endereço de login é nulo! Impossível prosseguir.',)));
          return;
        } // if(ENDPOINT_LOGIN == null) { ... }
        else if(ENDPOINT_LOGIN.trim().length <= 5) {
          Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Endereço de login é inválido! Impossível prosseguir.',)));
          return;
        } // else if(ENDPOINT_LOGIN.trim().length <= 5) { ... }
        else if(user == null || user.trim().isEmpty || user.length < 11) {
          Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Usuário não detectado! Tente novamente.',)));
          return;
        } // else if(user == null || user.trim().isEmpty || user.length < 11) { ... }
        else if(password == null || password.trim().isEmpty || password.length < 4) {
          Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Usuário não detectado! Tente novamente.',)));
          return;
        } // else if(password == null || password.trim().isEmpty || password.length < 4) { ... }
        else {
          // Declaração de variáveis
          String imeiData = await LoginController.initUniqueIdentifierState();

          
          Map<String, dynamic> body     = Map<String, dynamic>();
          body.putIfAbsent('cpf',           () => user.toString().padLeft(11,'0'));
          body.putIfAbsent('password',      () => password);
          body.putIfAbsent('mobile_device', () => imeiData.toString());

          Map<String, String> headers  = Map<String, String>();
          headers.putIfAbsent('accept',       () => 'application/json');
          // Declaração de variáveis

          // Realiza a requisição - Comunica com o servidor.
          final response  = await http.post(
            ENDPOINT_LOGIN,
            body: body,
            headers: headers,
          );
          // Realiza a requisição - Comunica com o servidor.

          Map<String, dynamic> dataResponse = jsonDecode(response.body);

          switch (response.statusCode) {
            case 200:
              // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
              if(!dataResponse['mobile_access']) {
                Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Usuário não possui permissão de acesso mobile! Verifique.',)));
              } // if(!dataResponse['mobile_access']) { ... }
              else {
                // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

                // Armazena os dados da resposta - Cria os dados de login
                context.read<EPraga>().login = Login.fromJson(dataResponse);
                bool validateData = await DataController.setDatabaseData(context, ['login','schudule', 'subsidiary']);

                // Armazena os dados da resposta - Cria os dados de login
                if(validateData){
                  Navigator.pushReplacement(context, FadePageRoute(MainPage()));
                }
                else {
                  Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Não foi possível acessar o banco de dados!',)));
                }
                //Navigator.pushReplacement(context, FadePageRoute(MainPage()));

                // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
              } // else { ... }

              break;
            default:
              Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: dataResponse['error']['message'],)));
          }

          return;
        } // else { ... }
      } // try { ... }
      catch(error) {
        print('---------');
        print(error);
        print('---------');
        Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Não foi possível efetuar o login! Verifique.',)));
        return;
      } // catch(error) { ... }
    } // else { ... }
  } // static Future requestLogin() async { ... }
} // class LoginController { ... }