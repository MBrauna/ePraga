import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'config.dart' as config;

class EPragaDB {
  static Future<Database> createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, config.DATABASE_NAME);
    Database database = await openDatabase(
      dbPath,
      version: config.DATABASE_VERSION,
      onCreate: EPragaDB.populateDB,
      onUpgrade: EPragaDB.upgradeDB,
    );

    return database;
  } // createDatabase() async { ... }

  static void populateDB(Database db, int version) async {
    // Salvar dados de login
    await db.execute('create table login(access_code integer primary key, password text, name text, hash text, last_login integer, token_date integer)');
    await db.execute('create table guide(id integer primary key, title text, body text, guide_date integer)');
    await db.execute('create table schudule(id integer primary key, description text, latitude text, longitude text, start_date integer, due_date integer, edit_date integer, location_name text, location_description text)');
    //await db.execute('create table task(id integer primary key, id_location integer, hash text, description text, exec integer)');
  } // void _populatedDB(Database db, int version) { ... }

  static void upgradeDB(Database db, int lastVersion, int actualVersion) {
  } // void _upgradeDB(Database db, int lastVersion, int actualVersion) { ... }
} // class EPragaDB { ... }