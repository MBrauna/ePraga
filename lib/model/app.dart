import 'package:flutter/material.dart';
import 'package:epraga/allFiles.dart';
import 'package:sqflite/sqflite.dart';

class App extends ChangeNotifier {
  Login login;
  Database database;

  // ---------------- # Listas # ---------------- //
  List<Schudule> listSchudule = List<Schudule>();
  List<Subsidiary> listSubsidiary = List<Subsidiary>();
  List<SchuduleItem> listSchuduleItem = List<SchuduleItem>();
  // ---------------- # Listas # ---------------- //
} // class App extends ChangeNotifier { ... }