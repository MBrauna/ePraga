import 'package:epraga/allFiles.dart';

class EPragaDB {
  static Future<Database> createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, DATABASE_NAME);
    Database database = await openDatabase(
      dbPath,
      version: DATABASE_VERSION,
      onCreate: EPragaDB.populateDB,
      onUpgrade: EPragaDB.upgradeDB,
    );

    return database;
  } // createDatabase() async { ... }

  static void populateDB(Database db, int version) async {
    // Salvar dados de login
    await db.execute('create table login(id integer primary key,name text,identity text,email text,device text,token text,last integer,expired integer)');
    await db.execute('create table schudule(id integer primary key,description text,id_subsidiary integer,id_responsible integer,last_alt integer,start_date integer,end_date integer,status integer,created_at integer,updated_at integer)');
    await db.execute('create table subsidiary(id integer primary key, id_company integer, latitude text, longitude text, name text, description text, address text)');
    await db.execute('create table schudule_item( id integer primary key, id_schudule integer, sequence integer, qtde_image integer, latitude text, longitude text, visit integer, combat integer, accept integer, status integer note text, description text, last_alt integer)');
  } // void _populatedDB(Database db, int version) { ... }

  static void upgradeDB(Database db, int lastVersion, int actualVersion) {
  } // void _upgradeDB(Database db, int lastVersion, int actualVersion) { ... }
} // class EPragaDB { ... }