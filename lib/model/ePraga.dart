import 'package:flutter/material.dart';

import './../database/ePragaDB.dart';
import 'allModels.dart';

class EPraga extends ChangeNotifier {
  EPragaDB database = EPragaDB();
  bool temaEscuro = false;
  Login login;
} // class EPraga extends ChangeNotifier { ... }
