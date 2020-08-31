import 'package:flutter/material.dart';
import 'package:epraga/allFiles.dart';

class Schudule extends ChangeNotifier {
  int _id;
  DateTime _dateStart, _dateDue, _editDate;
  num _latitude, _longitude;
  String _description, _locationName, _locationDescription;
  List<SchuduleItem> _listSchuduleItem;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  Schudule({
    int id,
    String description,
    DateTime startDate,
    DateTime dueDate,
    DateTime editDate,
    num latitude,
    num longitude,
    String locationName,
    String locationDescription,
    List<SchuduleItem> schuduleItemList,
  }) {
    if(id == null || id <= 0) {
      throw EPragaException(
        error: 'Impossível gerar agendamento com ID nulo! Verifique.',
        message: 'Impossível gerar agendamento com ID nulo! Verifique.',
        origin: this.runtimeType.toString(),
      );
    } // if(id == null || id <= 0) { ... }

    this._id            = id;
    this._description   = description ?? '';
    this._dateStart     = startDate ?? DateTime.now();
    this._editDate      = editDate == null ? DateTime.now() : editDate;
    this._dateDue       = dueDate;
    this._latitude      = latitude;
    this._longitude     = longitude;
    this._locationName  = locationName;
    this._locationDescription = locationDescription;

    if(schuduleItemList.length <= 0) {
      this._listSchuduleItem  = List<SchuduleItem>();
    }
    else {
      this._listSchuduleItem  = schuduleItemList;
    }
  }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory Schudule.fromJson(Map<String, dynamic> data) {
    List<SchuduleItem> itemList = List<SchuduleItem>();

    data['item'].forEach((element) {
      SchuduleItem dataItem = SchuduleItem.fromJson(element);
      itemList.add(dataItem);
    }); // data['item'].forEach((element) { ... }

    return Schudule(
      id: data['id_schudule'],
      description: data['description'] ?? '',
      startDate: data['start_date'] == null ? null : DateTime.parse(data['start_date']),
      dueDate: data['end_date'] == null ? null : DateTime.parse(data['end_date']),
      editDate: data['last_alt_at'] == null ? null : DateTime.parse(data['last_alt_at']),
      latitude: double.parse(data['subsidiary']['latitude']),
      longitude: double.parse(data['subsidiary']['longitude']),
      locationName: data['subsidiary']['name'],
      locationDescription: data['subsidiary']['description'],
      schuduleItemList: itemList,
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
  String get locationName =>  this._locationName;
  String get locationDesc =>  this._locationDescription;
  List<SchuduleItem> get listSchuduleItem => this._listSchuduleItem;

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