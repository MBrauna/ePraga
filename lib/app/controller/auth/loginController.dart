import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../../model/allModels.dart';

class LoginController {
  BuildContext _context;

  LoginController(BuildContext context) {
    this._context = context;
  } // LoginController(BuildContext context) { ... }

  Future<bool> getLogin(String user, String password) async {
    try {
      final response = await http.get('https://pastebin.com/raw/BgZwkn3L');

      if (response.statusCode == 200) {
        /*Map<String, dynamic> jsonReturn = jsonDecode(response.body);
        SharedPreferences vPreferences = await SharedPreferences.getInstance();

        final access = this._context.read<Epraga>();
        access.login = Login(
          user: jsonReturn['login']['usuario'],
          password: jsonReturn['login']['hahs'],
          name: jsonReturn['login']['nome'],
        );

        vPreferences.setInt('dataLogin', DateTime.now().millisecondsSinceEpoch);
        */
        return true;
      } // if(response.statusCode == 200) { ... }
      else {
        print(response);
        return false;
      } // else { ... }
    } // try { ... }
    catch (erro) {
      print(erro);
      return false;
    } // catch(erro) { ... }
  } // Future<bool> getLogin(String user, String passwrd) { ... }
} // class LoginController { ... }
