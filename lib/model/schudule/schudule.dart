import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import './../../app/exception/ePragaException.dart';
import 'task.dart';

class SchuduleEpraga extends ChangeNotifier {
  int       _id, _quantity;
  String    _description;
  DateTime  _execDate, _startDate, _endDate;
  bool      _status;
  List<Task> _listTask = List<Task>();

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  SchuduleEpraga({
    int id,
    int quantity,
    String description,
    DateTime execDate,
    DateTime startDate,
    DateTime endDate,
    bool status,
    List<Task> tasks,
  }) {
    if(id == null || id <= 0) {
      throw EPragaException(
        error: 'Impossível gerar agendamento com ID nulo! Verifique.',
        message: 'Impossível gerar agendamento com ID nulo! Verifique.',
        origin: this.runtimeType.toString(),
      );
    } // if(id == null || id <= 0) { ... }

    this._id          = id;
    this._quantity    = quantity ?? 0;
    this._description = description ?? '';
    this._execDate    = execDate ?? DateTime.now();
    this._startDate   = startDate;
    this._endDate     = endDate;
    this._status      = status ?? true;
    this._listTask    = tasks == null ? List<Task>() : tasks;
  }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory SchuduleEpraga.fromJson(Map<String, dynamic> data) {
    List<Task> listTask = List<Task>();

    if(data.containsKey('task')) {
      data['task'].forEach((element){
        listTask.add(Task.fromJson(element));
      });
    }

    return SchuduleEpraga(
      id: data['id'],
      description: data['description'] ?? '',
      startDate: data['startDate'] == null ? null : DateTime.fromMillisecondsSinceEpoch(data['startDate']),
      endDate: data['endDate'] == null ? null : DateTime.fromMillisecondsSinceEpoch(data['endDate']),
      execDate: data['execDate'] == null ? null : DateTime.fromMillisecondsSinceEpoch(data['execDate']),
      status: data['status'] ?? true,
      quantity: data['quantity'] ?? 0,
      tasks: listTask,
    );
  } // factory SchuduleEpraga.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  
  int get id              =>  this._id;
  int get quantity        =>  this._quantity;
  String get description  =>  this._description.trim();
  DateTime get startDate  =>  this._startDate;
  DateTime get endDate    =>  this._endDate;
  DateTime get execDate   =>  this._execDate;
  bool get status         =>  this._status ?? true;
  List<Task> get task     =>  this._listTask;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set startDate(DateTime date) {
    this._startDate = date;
    notifyListeners();
  }

  set endDate(DateTime date) {
    this._endDate = date;
    notifyListeners();
  }

  set task(List<Task> task){
    if(task == null || task.length <= 0) {
      this._listTask  = List<Task>();
    }
    else {
      this._listTask  = task;
    }
    notifyListeners();
  }
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  static Future<List<SchuduleEpraga>> getDB(Database database) async {
    List request = await database.query('schudule',where: 'status = 1 and end_date is null');
    List<Task> taskRequest = await Task.getListDB(database);
    List<SchuduleEpraga> returnData = List<SchuduleEpraga>();
    

    request.forEach((element) {
      List<Task> tmpTask  = List<Task>();

      taskRequest.forEach((taskElement) {
        if(element['id'] == taskElement.idSchudule) {
          tmpTask.add(taskElement);
        } // if(element['id'] == taskElement.idSchudule) { ... }
      });

      returnData.add(SchuduleEpraga(
        id: element['id'],
        description: element['description'],
        startDate: element['start_date'] == null ? null : DateTime.fromMillisecondsSinceEpoch(element['start_date']),
        endDate: element['end_date'] == null ? null : DateTime.fromMillisecondsSinceEpoch(element['end_date']),
        execDate: DateTime.fromMillisecondsSinceEpoch(element['exec_date']),
        quantity: element['quantity'],
        status: (element['status'] == 1) ? true : false,
        tasks: tmpTask,
      ));
    });
    return returnData;
  } // static Future<List<SchuduleEpraga>> getDB(Database database) async { ... }

  static Future<bool> setDB(Database database, SchuduleEpraga data) async {
    try {
      List request = await database.query('schudule',where: 'id = ${data.id}');
      if(request.length <= 0) {
        await database.transaction((txn) async {
          await txn.rawInsert('insert into schudule(id, description, start_date, end_date, exec_date, status, quantity) values(?,?,?,?,?,?,?)',[
            data.id,
            data.description,
            data.startDate == null ? null : data.startDate.millisecondsSinceEpoch,
            data.endDate == null ? null : data.endDate.millisecondsSinceEpoch,
            data.execDate.millisecondsSinceEpoch,
            data.status,
            data.quantity,
          ]);
        });
        print(data.task.length);

        if(data.task.length > 0){
          data.task.forEach((element) async {
            await Task.setDB(database, element);
          });
        } // if(data.task.length > 0){ ... }
      }

      return true;
    }
    catch(error) {
      return false;
    }
  }
} // class SchuduleEpraga extends ChangeNotifier { ... }