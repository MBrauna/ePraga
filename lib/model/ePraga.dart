import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

import './../database/ePragaDB.dart';
import 'allModels.dart';

class EPraga extends ChangeNotifier {
  bool temaEscuro   = false;
  Login login;
} // class EPraga extends ChangeNotifier { ... }
