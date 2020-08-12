import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:epraga/allFiles.dart';

class Login extends ChangeNotifier {
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int _accessCode;
  DateTime _lastLogin;
  String _password, _name, _hash;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

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

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory Login.fromJson(Map<String, dynamic> data, {String password}) {
    return Login(
      accessCode: data['id'],
      name: data['name'],
      hash: data['hash'],
      lastLogin: DateTime.fromMillisecondsSinceEpoch(data['lastLogin']),
      password: password ?? 'SENHAVAZIA',
    );
  } // factory Login.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int get user => this._accessCode;
  String get password => base64.encode(utf8.encode(this._accessCode.toString() + ':' + this._password));
  String get name => this._name;
  String get hash => this._hash;
  DateTime get lastLogin => this._lastLogin;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

}