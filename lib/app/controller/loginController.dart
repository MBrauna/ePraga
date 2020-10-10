import 'dart:convert';

import 'package:epraga/allFiles.dart';
import 'package:epraga/config/config.dart' as config;
import 'package:http/http.dart' as http;

class LoginController {
  static Future requestLogin(BuildContext context, String user, String password) async {
    try {
      bool network  = await VerifyNetwork().verify();

      if(!network) {
        Navigator.of(context).pushReplacement(FadePageRoute(LoginPage(message: 'Você está operando no modo offline!\nEsta etapa exige conexão com a rede.',)));
      }
      else {
        if(user == null || user.trim().isEmpty || user.trim().length < 11) {
          Navigator.of(context).pushReplacement(FadePageRoute(LoginPage(message: 'Usuário não detectado! Tente novamente.',)));
        } // if(user == null || user.trim().isEmpty || user.trim().length < 11) { ... }
        else if(password == null || password.trim().isEmpty || password.trim().length < 4) {
          Navigator.of(context).pushReplacement(FadePageRoute(LoginPage(message: 'Senha não detectado! Tente novamente',)));
        } // else if(password == null || password.trim().isEmpty || password.trim().length < 4) { ... }
        else {
          // Monta o corpo da requisição
          Map<String, dynamic> body = Map<String, dynamic>();
          body.putIfAbsent('cpf',           () => user.toString().padLeft(11,'0'));
          body.putIfAbsent('password',      () => password.trim());
          body.putIfAbsent('imei',          () => Provider.of<Mobile>(context,listen: false).imei.toString());
          body.putIfAbsent('plataform',     () => Provider.of<Mobile>(context,listen: false).platform.toString());
          // Monta os headers da requisição
          Map<String, String> headers  = Map<String, String>();
          headers.putIfAbsent('accept',       () => 'application/json');

          final response  = await http.post(
            config.ENDPOINT_LOGIN,
            body: body,
            headers: headers,
          );

          Map<String, dynamic> dataResponse = jsonDecode(response.body);
          
          switch(response.statusCode) {
            case 200:
              if(!dataResponse['mobile_access']) {
                Navigator.of(context).pushReplacement(FadePageRoute(LoginPage(message: 'Usuário não possui permissão de acesso mobile! Verifique.',)));
              } // if(!dataResponse['mobile_access']) { ... }
              else {
                // Armazena os dados - Cria os dados de login
                Login login = Login.fromJson(dataResponse);

                // Seta os dados na sessão e DB
                bool boolDataControl  = await DataController.setLogin(context, login);

                if(boolDataControl) {
                  Navigator.of(context).pushReplacement(FadePageRoute(MainPage()));
                }
                else {
                  Navigator.of(context).pushReplacement(FadePageRoute(LoginPage(message: 'Não foi possível montar os dados! Verifique.',)));
                }
              } // else { ... }

              break;
            case 401:
              LoginDao.deleteAllDB(context);
              Navigator.of(context).pushReplacement(FadePageRoute(LoginPage(message: 'Sua sessão expirou!',)));
              break;
            default:
              Navigator.of(context).pushReplacement(FadePageRoute(LoginPage(message: dataResponse['error']['message'],)));
              break;
          } // switch(response.statusCode) { ... }
        } // else { ... }
      } // else { ... }
      return;
    } // try { ... }
    catch(error, stacktrace){
      if(config.DEBUG) {
        print('[LoginController][requestLogin] ---------');
        print(error);
        print('## --------- ##');
        print(stacktrace);
        print('[LoginController][requestLogin] ---------');
      } // if(config.DEBUG) { ... }

      Navigator.of(context).pushReplacement(FadePageRoute(LoginPage(message: 'Não foi possível montar os dados de Login!\nTente novamente.',)));
    } // catch(error){ ... }
  } // static Future requestLogin(BuildContext context, String user, String password) { ... }
  
} // class LoginController { ... }