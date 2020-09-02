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
    await db.execute('create table login(id integer primary key,name text,identity text,email text,device text,token text,last integer,expired integer)');
    await db.execute('create table schudule(id integer primary key,description text,id_subsidiary integer,id_responsible integer,last_alt integer,start_date integer,end_date integer,status integer,created_at integer,updated_at integer)');
  } // void _populatedDB(Database db, int version) { ... }

  static void upgradeDB(Database db, int lastVersion, int actualVersion) {
  } // void _upgradeDB(Database db, int lastVersion, int actualVersion) { ... }
} // class EPragaDB { ... }