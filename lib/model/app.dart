import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'allModels.dart';

class App extends ChangeNotifier {
  Database database;
  Login login;

  // Dados para agendamentos.
  List<SchuduleEpraga> schudule = List<SchuduleEpraga>();  
}