import 'package:flutter/foundation.dart';

import './allModels.dart';
import './../app/exception/ePragaException.dart';

class Epraga extends ChangeNotifier with DiagnosticableTreeMixin {
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  Login _login;
  List<Access> _access;
  Access _logged;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  Epraga();

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  Login get login => this._login;
  List<Access> get access => this._access;
  Access get logged => this._logged;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  set login(Login login) {
    try {
      if (login != null) {
        this._login = login;
      } // if(login != null) { ... }
      else {
        throw Exception('Parâmetro inválido! Verifique.');
      } // else { ... }
    } // try { ... }
    catch (erro) {
      throw new EPragaException(
          error: erro,
          message: 'Não foi possível atribuir [EPRAGA][login]! Verifique.',
          origin: this.runtimeType.toString());
    } // catch(erro) { ... }
  } // set login(Login login){ ... }

  set access(List<Access> access) {
    try {
      if (access.length > 0) {
        this._access = access;
        this._logged = access.elementAt(0);
      } // if(access.length > 0) { ... }
      else {
        // Limpa a lista
        this._access = List<Access>();
      } // else { ... }
    } // try { ... }
    catch (erro) {
      throw new EPragaException(
          error: erro,
          message: 'Não foi possível atribuir [EPRAGA][access]! Verifique.',
          origin: this.runtimeType.toString());
    } // catch(erro) { ... }
  } // set access(List<Access> access) { ... }

  set logged(Access data) {
    try {
      if (data != null) {
        this._logged = data;
      } // if(access.length > 0) { ... }
      else {
        // Limpa a lista
        this._logged = null;
      } // else { ... }
    } // try { ... }
    catch (erro) {
      throw new EPragaException(
          error: erro,
          message: 'Não foi possível atribuir [EPRAGA][logged]! Verifique.',
          origin: this.runtimeType.toString());
    } // catch(erro) { ... }
  } // set logged(Access data) { ... }
} // class Epraga extends ChangeNotifier with DiagnosticableTreeMixin { ... }
