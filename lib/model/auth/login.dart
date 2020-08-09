import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

import './../../app/exception/ePragaException.dart';

class Login extends ChangeNotifier {
  int _accessCode;
  DateTime _lastLogin;
  String _password, _name, _hash;

  Login({int accessCode, String password, String hash, String name, DateTime lastLogin}) {
    if(accessCode == null || accessCode <= 0 || accessCode.toString().trim().isEmpty || password == null || password.length <= 0 || password.trim().isEmpty || hash == null || hash.trim().isEmpty || name == null || name.trim().isEmpty) {
      throw EPragaException(
        error: 'Parâmetro inválido! Verifique.',
        message: 'Parâmetro inválido! Verifique.',
        origin: this.runtimeType.toString(),
      );
    } // if(user == null || user <= 0 || user.toString().trim().isEmpty || password == null || password.length <= 0 || password.trim().isEmpty) { ... }

    this._accessCode = accessCode;
    this._password = password;
    this._name  = name;
    this._hash  = hash;

    if(lastLogin == null) {
      this._lastLogin = DateTime.now();
    }
    else {
      this._lastLogin = lastLogin;
    }
  } // Login(int user, String password) { ... }

  int get user => this._accessCode;
  String get password => base64.encode(utf8.encode(this._accessCode.toString() + ':' + this._password));

  static Future<Login> getDB(Database database) async {
    List request = await database.query('login');
    List<Login> returnData  = List<Login>();

    request.forEach((element) {
      returnData.add(Login(
        accessCode: element['accessCode'],
        password: element['password'],
        hash: element['hash'],
        name: element['name'],
        lastLogin: DateTime.fromMillisecondsSinceEpoch(element['last_login']),
      ));
    });

    return returnData[0];
  } // Login getDB(Database database) { .. }
}