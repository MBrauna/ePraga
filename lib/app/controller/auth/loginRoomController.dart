import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import './../../wscom/loginRequest.dart';
import './../../../model/allModels.dart' as models;

class LoginRoomController {
  Future<bool> login(String accessCode, String password, Database db) async {
    try {
      Map<String, dynamic> request  = await LoginRequest.getLogin();
      models.Login loginData;

      if(request['status'] == 200) {
        loginData = models.Login.fromJson(request);
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setInt('dataLogin', DateTime.now().millisecondsSinceEpoch);

        try {
          await db.delete('login');
          await db.rawInsert('INSERT INTO login(access_code, name, hash, last_login) values(?,?,?,?)', [loginData.id, loginData.name, loginData.hash, loginData.lastLogin.millisecondsSinceEpoch]);
          return true;
        }
        catch(erro) {
          sharedPreferences.remove('dataLogin');
          return false;
        }
      }


      return false;
    } // try { ... }
    catch(erro) {
      return false;
    } // catch(erro) { ... }
  } // Future<void> login(String accessCode, String password) { ... }
} // class LoginRoomController { ... }