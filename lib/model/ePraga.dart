import 'package:flutter/foundation.dart';

import './auth/login.dart';

class Epraga extends ChangeNotifier with DiagnosticableTreeMixin {
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  Login _login;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  Epraga({Login login}) {
    this._login = login;
  } // Epraga({}) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  Login get login => this._login;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  set login(Login login) {
    this._login = login;
    notifyListeners();
  } // set login(Login login){ ... }
} // class Epraga extends ChangeNotifier with DiagnosticableTreeMixin { ... }
