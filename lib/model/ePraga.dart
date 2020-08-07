import 'package:flutter/material.dart';
import './../database/ePragaDB.dart';

class EPraga extends ChangeNotifier {
  EPragaDB database = EPragaDB();
  bool temaEscuro   = false;

  EPraga();
} // class EPraga extends ChangeNotifier { ... }
