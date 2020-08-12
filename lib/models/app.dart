import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:epraga/allFiles.dart';

class App extends ChangeNotifier {
  App();
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  Database _database;
  Login _login;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  Database get database => this._database;
  Login get login => this._login;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  set database(Database database) {
    if(database != null) {
      this._database = database;
      notifyListeners();
    } // if(database != null) { ... }
  } // set database(Database database) { ... }

  set login(Login login) {
    if(login != null) {
      this._login = login;
      notifyListeners();
    } // if(login != null) { ... }
  } // set login(Login login) { ... }
} // class App extends ChangeNotifier { ... }