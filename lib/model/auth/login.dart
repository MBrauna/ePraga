import 'package:flutter/foundation.dart';
import 'dart:convert';

import './../../config.dart' as config;
import './../../app/exception/ePragaException.dart';

class Login extends ChangeNotifier with DiagnosticableTreeMixin {
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  int _accessCode;
  String _password;
  DateTime _lastLogin = DateTime.now();
  int _versionCode = config.APP_VERSION;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  Login({int accessCode, String password}) {
    try {
      if (accessCode.toString().trim().isNotEmpty) {
        this._accessCode = accessCode;
      } // if(user.toString().trim().isNotEmpty) { ... }

      if (password.trim().isNotEmpty) {
        this._password = password;
      } // if(password.trim().isNotEmpty) { ... }
    } // try { ... }
    catch (erro) {
      throw new EPragaException(
        error: erro,
        message: 'Não foi possível inicializar a classe [LOGIN]! Verifique.',
        origin: this.runtimeType.toString()
      );
    } // catch(erro){ ... }
  } // Login({int user, String password}) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  DateTime get loginDate => this._lastLogin;
  int get accessCode => this._accessCode;
  int get versionCode => this._versionCode;
  String get hash => base64.encode(utf8.encode(this._accessCode.toString() + ':' + this._password));

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  set accessCode(int accessCode) {
    try {
      if(accessCode.toString().trim().isNotEmpty) {
        this._accessCode = accessCode;
        notifyListeners();
      } // if(accessCode.toString().trim().isNotEmpty) { ... }
      else {
        throw Exception('Campo inválido');
      } // else { ... }
    }
    catch(erro) {
      throw new EPragaException(
        error: erro,
        message: 'Não foi possível alterar o campo [LOGIN][accessCode]! Verifique.',
        origin: this.runtimeType.toString()
      );
    }
  } // set accessCode([int accessCode]) { ... }

  set password(String password) {
    try {
      if(password.trim().isNotEmpty) {
        this._password = password;
        notifyListeners();
      } // if(password.trim().isNotEmpty) { ... }
      else {
        throw Exception('Campo inválido');
      } // else { ... }
    }
    catch(erro) {
      throw new EPragaException(
        error: erro,
        message: 'Não foi possível alterar o campo [LOGIN][password]! Verifique.',
        origin: this.runtimeType.toString()
      );
    }
  } // set password(String password) { ... }
} // class Login extends ChangeNotifier with DiagnosticableTreeMixin { ... }
