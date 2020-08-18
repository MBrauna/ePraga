import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:epraga/allFiles.dart';

class App extends ChangeNotifier {
  App();
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  Database _database;
  Login _login;
  List<Guide> _listGuide        = List<Guide>();
  List<Schudule> _listSchudule  = List<Schudule>();

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  Database get database => this._database;
  Login get login => this._login;
  List<Guide> get guide => this._listGuide;
  List<Schudule> get schudule => this._listSchudule;

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

  set guide(List<Guide> guide) {
    if(guide == null) {
      this._listGuide = List<Guide>();
    } // if(guide.length <= 0 || guide == null) { ... }
    else {
      this._listGuide = guide;
    }
    notifyListeners();
  } // set guide(List<Guide> guide) { ... }

  set schudule(List<Schudule> data) {
    if(data == null) {
      this._listSchudule = List<Schudule>();
    } // if(data == null) { ... }
    else {
      this._listSchudule  = data;
    } // else { ... }
    notifyListeners();
  } // set schudule(List<Schudule> data) { ... }
} // class App extends ChangeNotifier { ... }