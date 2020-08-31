import 'package:flutter/material.dart';

class SchuduleItem extends ChangeNotifier {
  int _schuduleItem, _schuduleID, _sequence, _quantityImages;
  num _latitude, _longitude;
  String _description, _note;
  bool _visit, _pestControl;
  DateTime _lastAltAt, _startDate, _endDate;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  SchuduleItem({
    int schuduleItem,
    int idSchudule,
    int sequence = 999,
    int quantityImages = 1,
    num latitude,
    num longitude,
    String description,
    bool visit,
    bool pestControl,
    DateTime lastAltAt,
    DateTime startDate,
    DateTime endDate,
    String note = '',
  }){
    this._schuduleItem    = schuduleItem;
    this._schuduleID      = idSchudule;
    this._sequence        = sequence ?? 999;
    this._quantityImages  = quantityImages ?? 1;
    this._latitude        = latitude;
    this._longitude       = longitude;
    this._description     = description;
    this._visit           = visit;
    this._pestControl     = pestControl;
    this._lastAltAt       = lastAltAt == null ? DateTime.now() : lastAltAt;
    this._startDate       = startDate == null ? DateTime.now() : startDate;
    this._endDate         = endDate   == null ? DateTime.now() : endDate;
    this._note            = note;
  }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory SchuduleItem.fromJson(Map<String, dynamic> data) {
    return SchuduleItem(
      schuduleItem: data['id_schudule_item'],
      idSchudule: data['id_schudule'],
      description: data['description'],
      visit: data['visit'],
      pestControl: data['pest_control'],
      sequence: data['sequence'],
      latitude: data['latitude'] == null ? null : double.parse(data['latitude']),
      longitude: data['longitude'] == null ? null : double.parse(data['longitude']),
      lastAltAt: data['last_alt_at'] == null ? DateTime.now() : DateTime.parse(data['last_alt_at']),
      startDate: data['start_date'] == null ? null : DateTime.parse(data['start_date']),
      endDate: data['end_date'] == null ? null : DateTime.parse(data['end_date']),
      quantityImages: data['quantity_images'] ?? 1,
      note: data['note'],
    );
  } // factory SchuduleItem.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int get id => this._schuduleItem;
  int get idSchudule => this._schuduleID;
  String get description => this._description;
  bool get visit => this._visit;
  bool get pestControl => this._pestControl;
  int get sequence => this._sequence;
  num get latitude => this._latitude;
  num get longitude => this._longitude;
  DateTime get lastAltAt => this._lastAltAt;
  DateTime get startDate => this._startDate;
  DateTime get endDate => this._endDate;
  int get quantityImages => this._quantityImages;
  String get note => this._note;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set latitude(num latitude) {
    this._latitude  = latitude;
    this._lastAltAt = DateTime.now();
    notifyListeners();
  } // set latitude(num latitude) { ... }

  set longitude(num longitude) {
    this._longitude = longitude;
    this._lastAltAt = DateTime.now();
    notifyListeners();
  } // set longitude(num longitude) { ... }

  set startDate(DateTime date){
    this._startDate = date;
    this._lastAltAt = DateTime.now();
    notifyListeners();
  } // set startDate(DateTime date){ ... }

  set endDate(DateTime date) {
    this._endDate   = date;
    this._lastAltAt = DateTime.now();
    notifyListeners();
  } // set endDate(DateTime date) { ... }

  set note(String note) {
    this._note  = note;
    notifyListeners();
  } // set note(String note) { ... }
} // class Schudule extends ChangeNotifier { ... }