import './../wservice/wsLogin.dart';
import './../../../model/allModels.dart' show Login;

class LoginController {
  LoginController();

  Future<Map<String, dynamic>> getLogin(int user, String password) async {
    Map<String, dynamic> response = Map<String, dynamic>();

    try {
      // Monta a classe de login para requisição
      Login login = Login(accessCode: user, password: password);

      // Requisita ao servidor EPRAGA as informações
      //response = await WsLogin().getLogin(login);
    } // try { ... }
    catch (erro) {} // catch(erro) { ... }
  } // Future<bool> getLogin(String user, String passwrd) { ... }
} // class LoginController { ... }
