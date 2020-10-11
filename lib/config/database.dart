import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:epraga/config/config.dart' as config;

class EpragaDB extends ChangeNotifier {
  static Future<Database> createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, config.DATABASE_NAME);
    Database database = await openDatabase(
      dbPath,
      version: config.DATABASE_VERSION,
      onCreate: EpragaDB.populateDB,
      onUpgrade: EpragaDB.upgradeDB,
    );

    return database;
  } // createDatabase() async { ... }

  static void populateDB(Database db, int version) async {
    await db.execute('create table login(id integer primary key, name text, cpf_cnpj text, hash text, last_login int, expired_login int)');
    await db.execute('create table schudule(id_schudule integer primary key, id_subsidiary integer, description text, last_alt integer, status integer)');
    await db.execute('create table subsidiary(id_subsidiary integer primary key, id_company integer, name text, company text, description text, address text, latitude text, longitude text, croqui text)');
    await db.execute('create table schudule_item(id_schudule_item integer primary key, id_schudule integer, spot integer, description text, last_alt integer, sequence integer default 99, qtde_images integer default 1, accept integer default 0, visit integer default 0)');
    await db.execute('create table image(id integer primary key,id_img_schudule integer, id_schudule_item integer, base64img text, created_at integer)');
    await db.execute('create table product(id_product integer primary key, id_category integer, quantity real, description text, measure text)');
    await db.execute('create table sender(id integer primary key, url text, content text, status integer default 0)');
  } // static void populateDB(Database db, int version) async { ... }


  static void upgradeDB(Database db, int lastVersion, int actualVersion) {

  } // static void upgradeDB(Database db, int lastVersion, int actualVersion) { ... }
} // class EpragaDB extends ChangeNotifier { ... }