import 'package:flutter/material.dart';
import 'package:epraga/allFiles.dart';

class Schudule extends ChangeNotifier {
  int _id;
  DateTime _dateStart, _dateDue, _editDate;
  num _latitude, _longitude;
  String _description;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  Schudule({
    int id,
    String description,
    DateTime startDate,
    DateTime dueDate,
    DateTime editDate,
    num latitude,
    num longitude,
  }) {
    if(id == null || id <= 0) {
      throw EPragaException(
        error: 'Impossível gerar agendamento com ID nulo! Verifique.',
        message: 'Impossível gerar agendamento com ID nulo! Verifique.',
        origin: this.runtimeType.toString(),
      );
    } // if(id == null || id <= 0) { ... }

    this._id          = id;
    this._description = description ?? '';
    this._dateStart   = startDate ?? DateTime.now();
    this._editDate    = editDate == null ? DateTime.now() : editDate;
    this._dateDue     = dueDate;
    this._latitude    = latitude;
    this._longitude   = longitude;
  }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory Schudule.fromJson(Map<String, dynamic> data) {
    
    return Schudule(
      id: data['id'],
      description: data['description'] ?? '',
      startDate: data['startDate'] == null ? null : DateTime.fromMillisecondsSinceEpoch(data['startDate']),
      dueDate: data['dueDate'] == null ? null : DateTime.fromMillisecondsSinceEpoch(data['dueDate']),
      editDate: data['editDate'] == null ? null : DateTime.fromMillisecondsSinceEpoch(data['editDate']),
      latitude: data['location']['latitude'],
      longitude: data['location']['longitude'],
    );
  } // factory Schudule.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  
  int get id              =>  this._id;
  String get description  =>  this._description.trim();
  DateTime get startDate  =>  this._dateStart;
  DateTime get dueDate    =>  this._dateDue;
  DateTime get editDate   =>  this._editDate;
  num get latitude        =>  this._latitude;
  num get longitude       =>  this._longitude;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set dueDate(DateTime date) {
    this._dateDue = date;
    this._editDate = date;
    notifyListeners();
  }

  set editDate(DateTime date) {
    this._editDate  = date;
    notifyListeners();
  }

} // class SchuduleEpraga extends ChangeNotifier { ... }