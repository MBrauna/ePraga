import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../app/exception/ePragaException.dart';

class Task extends ChangeNotifier {
  int _id, _idSchudule, _idPrague, _quantityImages;
  String _description, _note;
  num _latitude, _longitude;
  DateTime _execDate;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  Task({
    int id,
    int idSchudule,
    String description = 'Tarefa a realizar',
    num latitude,
    num longitude,
    int idPrague,
    String note = '',
    int quantityImages,
    DateTime execDate
  }) {
    if(id == null || id <= 0 || idSchudule == null || idSchudule <= 0 || idPrague == null || idPrague <= 0) {
      throw new EPragaException(
        error: 'Parâmetros inválidos!',
        message: 'Parâmetros inválidos!',
        origin: this.runtimeType.toString(),
      );
    } // if(id == null || id <= 0 || idPrague == null || idPrague <= 0) { ... }

    this._id  = id;
    this._idSchudule  = idSchudule;
    this._description = description;
    this._latitude  = latitude;
    this._longitude = longitude;
    this._idPrague  = idPrague;
    this._note      = note;
    this._quantityImages  = quantityImages;
    this._execDate  = execDate;
  }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory Task.fromJson(Map<String, dynamic> data) {
    return Task(
      id: data['id'],
      idSchudule: data['idSchudule'],
      description: data['description'],
      idPrague: data['idPrague'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      note: data['note'],
      quantityImages: data['quantityImages'],
      execDate: data['execDate'],
    );
  } // factory Task.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int get id => this._id;
  int get idSchudule => this._idSchudule;
  int get idPrague => this._idPrague;
  int get quantityImages => this._quantityImages;
  String get description => this._description;
  String get note => this._note;
  num get latitude => this._latitude;
  num get longitude => this._longitude;
  DateTime get execDate => this._execDate;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set note(String note){
    if(note == null || note.trim().isEmpty || note.length <= 5) {
      this._note  = '';
    } // if(note == null || note.trim().isEmpty || note.length <= 5) { .. }
    else {
      this._note  = note;
    } // else { ... }
    notifyListeners();
  } // set note(String note){ ... }

  set execDate(DateTime date) {
    if(date == null) {
      this._execDate = null;
    }
    else {
      this._execDate  = date;
    }
  } // set execDate(DateTime date) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  static Future<List<Task>> getDB(Database database, int idSchudule) async {
    List request = await database.query('task',where: 'id_schudule = ${idSchudule.toString()}');
    List<Task> returnData = List<Task>();

    request.forEach((element) {
      returnData.add(Task(
        id: element['id'],
        idSchudule: element['id_schudule'],
        description: element['description'],
        idPrague: element['id_prague'],
        latitude: element['latitude'],
        longitude: element['longitude'],
        note: element['note'],
        quantityImages: element['qtde_img'],
        execDate: element['exec_date'] == null ? null : DateTime.fromMillisecondsSinceEpoch(element['exec_date']),
      ));
    });

    return returnData;
  } // static Future<List<SchuduleEpraga>> getDB(Database database) async { ... }

  static Future<List<Task>> getListDB(Database database) async {
    List request = await database.query('task');
    List<Task> returnData = List<Task>();

    request.forEach((element) {
      returnData.add(Task(
        id: element['id'],
        idSchudule: element['id_schudule'],
        description: element['description'],
        idPrague: element['id_prague'],
        latitude: element['latitude'],
        longitude: element['longitude'],
        note: element['note'],
        quantityImages: element['qtde_img'],
        execDate: element['exec_date'] == null ? null : DateTime.fromMillisecondsSinceEpoch(element['exec_date']),
      ));
    });

    return returnData;
  } // static Future<List<SchuduleEpraga>> getDB(Database database) async { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  static Future<bool> setDB(Database database, Task data) async {
    try {
      List request = await database.query('task',where: 'id = ${data.id}');
      if(request.length <= 0) {
        await database.transaction((txn) async {
          await txn.rawInsert('insert into task(id, id_schudule, description, id_prague, latitude, longitude, note, qtde_img, exec_date) values(?,?,?,?,?,?,?,?,?)',[
            data.id,
            data.idSchudule,
            data.description,
            data.idPrague,
            data.latitude,
            data.longitude,
            data.note,
            data.quantityImages,
            data.execDate == null ? null : data.execDate.millisecondsSinceEpoch
          ]);
        });
      }

      return true;
    }
    catch(error) {
      return false;
    }
  }
} // class Task extends ChangeNotifier { ... }