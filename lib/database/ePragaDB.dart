import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import './../config.dart' as config;

class EPragaDB extends ChangeNotifier{

  Future<Database> createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, config.DATABASE_NAME);
    Database database = await openDatabase(
      dbPath,
      version: config.DATABASE_VERSION,
      onCreate: _populateDB,
      onUpgrade: _upgradeDB,
    );

    return database;
  } // createDatabase() async { ... }

  void _populateDB(Database db, int version) async {
    // Salvar dados de login
    await db.execute('create table login(access_code integer primary key, password text, name text, hash text, last_login integer)');
    await db.execute('create table schudule(id integer primary key, description text, start_date integer, end_date integer, exec_date integer, status integer, quantity integer)');
    await db.execute('create table task(id integer primary key, id_schudule integer, description text, id_prague integer, latitude NUMERIC, longitude numeric, note text, qtde_img integer, exec_date integer)');
    //await db.execute('create table task(id integer primary key, id_location integer, hash text, description text, exec integer)');
  } // void _populatedDB(Database db, int version) { ... }

  void _upgradeDB(Database db, int lastVersion, int actualVersion) {
  } // void _upgradeDB(Database db, int lastVersion, int actualVersion) { ... }
}