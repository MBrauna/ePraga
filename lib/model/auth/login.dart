import 'package:epraga/app/exception/ePragaException.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

class Login extends ChangeNotifier with DiagnosticableTreeMixin {
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  int _user;
  String _password;
  String _name;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  Login({int user, String password, String name}) {
    this._user = user;
    this._password = password;
    this._name = name;
  } // Login() { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  int get user => this._user;
  String get password => base64.encode(utf8.encode(this._password));
  String get name => this._name;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  set user(int user) {
    if (user.toString().isEmpty) {
      throw EPragaException(
        error: 'Usuário inválido! Verifique.',
        message: 'Usuário inválido! Verifique.',
        origin: this.runtimeType.toString(),
      );
    } // if(user.toString().isEmpty) { ... }

    this._user = user;
    notifyListeners();
  } // set user(int user) { ... }

  set password(String password) {
    if (password.isEmpty) {
      throw EPragaException(
        error: 'Senha inválida! Verifique.',
        message: 'Senha inválida! Verifique.',
        origin: this.runtimeType.toString(),
      );
    } // if(password.isEmpty) { ... }

    this._password = password;
    notifyListeners();
  } // set password(String password) { ... }

  set name(String name) {
    if (name.isEmpty) {
      throw EPragaException(
        error: 'Nome inválido! Verifique.',
        message: 'Nome inválido! Verifique.',
        origin: this.runtimeType.toString(),
      );
    }

    this._name = name;
    notifyListeners();
  } // set name(String name) { ... }
} // class Login extends ChangeNotifier with DiagnosticableTreeMixin { ... }
