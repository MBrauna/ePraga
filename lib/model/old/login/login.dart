import 'dart:convert';

import 'package:epraga/app/exception/ePragaException.dart';

class Login {
  int       _user;
  String    _password;
  DateTime  _dateLogin;
  DateTime  _dateExpired;

  /// [GETTERS] - Procedimentos para coleta de dados
  int get user => this._user;
  String get password =>  base64.encode(utf8.encode(this._password));
  DateTime get dateLogin => this._dateLogin;
  DateTime get dateExpired => this._dateExpired;

  /// [CONSTRUCTOR] - Método construtor para Login
  Login(int user, String password) {
    if(user.toString().trim().isEmpty || password.trim().isEmpty || password.trim().length <= 4) EPragaException(error: 'Login inválido',origin: this.runtimeType.toString().trim().toUpperCase(), message: 'Login inválido! Não foi possível realizar o login neste momento.');
    this._user        = user;
    this._password    = password;
    this._dateLogin   = DateTime.now();
    this._dateExpired = DateTime.now().add(Duration(days: 2));
  } // Login(int user, String password) { ... }
}