import 'package:flutter/material.dart';

class ImageBase64 extends ChangeNotifier {

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  String _base64;
  int _idSchuduleItem;
  DateTime _lastAlt;
  num _latitude, _longitude;
  bool _execUpdate;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  String get base64 => this._base64;
  int get idSchuduleItem => this._idSchuduleItem;
  DateTime get lastAlt => this._lastAlt;
  num get latitude => this._latitude;
  num get longitude => this._longitude;
  bool get execUpdate => this._execUpdate;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  ImageBase64({int idSchuduleItem, String base64, DateTime lastAlt, bool execUpdate = true, num latitude, num longitude}) {
    this._idSchuduleItem  = idSchuduleItem;
    this._base64          = base64;

    if(lastAlt == null) {
      this._lastAlt       = DateTime.now();
    } // if(createdAt == null) { ... }
    else {
      this._lastAlt       = lastAlt;
    } // else { ... }

    this._latitude        = latitude;
    this._longitude       = longitude;
    this._execUpdate      = execUpdate;
  } // Image({String image, DateTime createdAt, DateTime updatedAt, bool execUpdate}) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory ImageBase64.fromJson(Map<String, dynamic> data) {
    return ImageBase64(
      base64: data['base64'],
      execUpdate: true,
      lastAlt: data['updated_at'] == null ? DateTime.now() : DateTime.parse(data['updated_at']),
      latitude: data['latitude'],
      longitude: data['longitude'],
      idSchuduleItem: data['id_schudule_item'],
    );
  } // factory Image.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set base64(String data) {
    this._base64  = data;
    this._lastAlt = DateTime.now();
    notifyListeners();
  } // set base64(String data) { ... }

  set latitude(num latitude) {
    this._latitude  = latitude;
    this._lastAlt   = DateTime.now();
    notifyListeners();
  } // set latitude(num latitude) { ... }

  set longitude(num longitude) {
    this._longitude = longitude;
    this._lastAlt   = DateTime.now();
    notifyListeners();
  } // set longitude(num longitude) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
} // class Image extends ChangeNotifier { ... }