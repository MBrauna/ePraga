import './../wservice/wsLogin.dart';
import './../../../model/allModels.dart' show Login, Access;

class LoginController {
  LoginController();

  Future<Map<String, dynamic>> getLogin(int user, String password) async {
    Map<String, dynamic> response = Map<String, dynamic>();

    try {
      // Monta a classe de login para requisição
      Login login = Login(accessCode: user, password: password);
      response    = await WsLogin().getLogin(login);
      response['login']  = login;
      return response;
    } // try { ... }
    catch (erro) {
      response = Map<String, dynamic>();
      response['code']   = 999;
      response['error']  = 'Você não possui permissão para acesso! Verifique.';
      return response;
    } // catch(erro) { ... }
  } // Future<bool> getLogin(String user, String passwrd) { ... }
} // class LoginController { ... }
