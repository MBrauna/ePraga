import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import './../config.dart' as config;
import './../model/allModels.dart' as models;

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
    await db.execute('create table login(access_code integer primary key, name text, hash text, last_login integer)');
    await db.execute('create table prague(id integer primary key, name text, description text)');
    await db.execute('create table schudule(id integer primary key, description text, cadastro int, execucao int)');
    await db.execute('create table sendmessage(id integer primary key, jsondata text)');
  } // void _populatedDB(Database db, int version) { ... }

  void _upgradeDB(Database db, int lastVersion, int actualVersion) {
  } // void _upgradeDB(Database db, int lastVersion, int actualVersion) { ... }

  Future<bool> insereLogin(models.Login login) async{
    try {
      await this.database.rawDelete('delete from login');
      await this.database.rawInsert('insert into login(access_code, name, hash, last_login) values(${login.id.toString()}, ${login.name}, ${login.hash}, ${login.lastLogin.toString()})');

      return true;
    }
    catch(erro) {
      return false;
    }
  }
} // class EPragaDB { ... }
