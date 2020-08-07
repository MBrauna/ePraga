import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import './../config.dart' as config;

class EPragaDB extends ChangeNotifier {
  bool concluded = false;
  Database database;

  EPragaDB() {
    createDatabase();
  } // EPragaDB(){ ... }

  createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, config.DATABASE_NAME);

    this.database = await openDatabase(
      dbPath,
      version: config.DATABASE_VERSION,
      onCreate: _populateDB,
      onUpgrade: _upgradeDB,
    );
    this.concluded = true;
    notifyListeners();
  } // createDatabase() async { ... }

  void _populateDB(Database db, int version) async {
    // Salvar dados de login
    await db.execute('create database login(access_code integer primary key, hash text, last_login integer)');
    await db.execute('create database prague(id integer primary key, name text, description text)');
    await db.execute('create database schudule(id integer primary key, description text, cadastro int, execucao int)');
    await db.execute('create database sendmessage(id integer primary key, jsondata text)');
  } // void _populatedDB(Database db, int version) { ... }

  void _upgradeDB(Database db, int lastVersion, int actualVersion) {
  } // void _upgradeDB(Database db, int lastVersion, int actualVersion) { ... }
} // class EPragaDB { ... }
