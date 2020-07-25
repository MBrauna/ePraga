import 'package:epraga/app/exception/ePragaException.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

class Login extends ChangeNotifier with DiagnosticableTreeMixin {
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  int _user;
  String _password;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  Login({int user, String password}) {
    this._user = user;
    this._password = password;
  } // Login() { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  int get user => this._user;
  String get password => base64.encode(utf8.encode(this._password));

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
} // class Login extends ChangeNotifier with DiagnosticableTreeMixin { ... }
