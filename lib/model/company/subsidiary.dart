import 'package:flutter/material.dart';

class Subsidiary extends ChangeNotifier {
  int _id, _idCompany;
  num _latitude, _longitude;
  String _name, _description, _address;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  Subsidiary({int id, int idCompany, num latitude, num longitude, String name, String description, String address}) {
    this._id          = id;
    this._idCompany   = idCompany;
    this._latitude    = latitude;
    this._longitude   = longitude;
    this._name        = name;
    this._description = description;
    this._address     = address;
  } // Subsidiary({int id, int idCompany, num latitude, num longitude, String name, String description, String address}) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory Subsidiary.fromJson(Map<String, dynamic> data){
    return Subsidiary(
      id: data['id_subsidiary'],
      idCompany: data['id_company'],
      name: data['name'],
      description: data['description'],
      address: data['address'],
      latitude: data['latitude'],
      longitude: data['longitude'],
    );
  } // factory Subsidiary.fromJson(Map<String, dynamic> data){ ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int get id => this._id;
  int get idCompany => this._idCompany;
  num get latitude => this._latitude;
  num get longitude => this._longitude;
  String get name => this._name;
  String get description => this._description;
  String get address => this._address;


} // class Subsidiary extends ChangeNotifier { ... }