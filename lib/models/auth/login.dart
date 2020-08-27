import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:epraga/allFiles.dart';

class Login extends ChangeNotifier {
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int _accessCode;
  DateTime _lastLogin, _tokenDate;
  String _password, _name, _hash;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  Login({int accessCode, String password, String hash, String name, DateTime lastLogin, DateTime tokenDate}) {
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
    this._tokenDate = tokenDate;

    if(lastLogin == null) {
      this._lastLogin = DateTime.now();
    }
    else {
      this._lastLogin = lastLogin;
    }
  } // Login(int user, String password) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory Login.fromJson(Map<String, dynamic> data, {String password}) {
    return Login(
      accessCode: data['id'],
      name: data['name'],
      hash: data['api_token'],
      lastLogin: DateTime.parse(data['last_login']),
      password: password ?? 'SENHAVAZIA',
      tokenDate: data['api_expiring'].toString().isEmpty ? null : DateTime.parse(data['api_expiring']),
    );
  } // factory Login.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int get user => this._accessCode;
  String get password => base64.encode(utf8.encode(this._accessCode.toString() + ':' + this._password));
  String get name => this._name;
  String get hash => this._hash;
  DateTime get lastLogin => this._lastLogin;
  DateTime get tokenDate => this._tokenDate;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set tokenDate(DateTime date) {
    this._tokenDate = date;
    notifyListeners();
  } // set tokenDate(DateTime date) { ... }

  set hash(String token) {
    this._hash = token;
    notifyListeners();
  }

}