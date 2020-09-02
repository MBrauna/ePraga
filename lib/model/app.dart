import 'package:flutter/material.dart';
import 'package:epraga/allFiles.dart';
import 'package:sqflite/sqflite.dart';

class App extends ChangeNotifier {
  Login login;
  Database database;
  List<Schudule> listSchudule = List<Schudule>();
} // class App extends ChangeNotifier { ... }