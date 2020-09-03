import 'package:flutter/material.dart';

class SchuduleItem extends ChangeNotifier {
  
  int _id, _idSchudule, _sequence, _qtdeImage;
  num _latitude, _longitude;
  bool _visit, _combat, _accept, _status;
  String _note, _description;
  DateTime _lastAlt;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  SchuduleItem({int id, int idSchudule, int sequence, int qtdeImage, num latitude, num longitude, bool visit = false, bool combat = false, bool accept = false, bool status = true, String note, String description, DateTime lastAlt}){
    this._id          = id;
    this._idSchudule  = idSchudule;
    this._sequence    = sequence;
    this._qtdeImage   = qtdeImage;
    this._latitude    = latitude;
    this._longitude   = longitude;
    this._visit       = visit;
    this._combat      = combat;
    this._accept      = accept;
    this._status      = status;
    this._note        = note;
    this._description = description;
    this._lastAlt     = lastAlt;
  } // SchuduleItem({int id, int idSchudule, int sequence, int qtdeImage, num latitude, num longitude, bool visit = false, bool combat = false, bool accept = false, bool status = true, String note, String description}){ ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int get id => this._id;
  int get idSchudule => this._idSchudule;
  int get sequence => this._sequence;
  int get qtdeImage => this._qtdeImage;
  num get latitude => this._latitude;
  num get longitude => this._longitude;
  bool get visit => this._visit;
  bool get combat => this._combat;
  bool get accept => this._accept;
  bool get status => this._status;
  String get note => this._note;
  String get description => this._description;
  DateTime get lastAlt => this._lastAlt;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory SchuduleItem.fromJson(Map<String, dynamic> data) {
    return SchuduleItem(
      id: data['id_schudule_item'],
      idSchudule: data['id_schudule'],
      description: data['description'],
      note: data['note'],
      visit: data['visit'],
      combat: data['pest_control'],
      sequence: data['sequence'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      qtdeImage: data['quantity_images'],
      lastAlt: data['last_alt_at'] == null ? DateTime.now() : DateTime.parse(data['last_alt_at']),
      accept: data['accept'],
      status: data['status'],
    );
  } // factory SchuduleItem.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set accept(bool value){
    this._accept = value;
    notifyListeners();
  }
  


} // class SchuduleItem extends StatelessElement { ... }