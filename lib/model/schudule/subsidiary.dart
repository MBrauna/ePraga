import 'package:flutter/material.dart';
import 'package:epraga/config/config.dart' as config;

class Subsidiary extends ChangeNotifier {
  int _idSubsidiary, _idCompany;
  num _latitude, _longitude;
  String _name, _company, _description, _address, _croqui;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  Subsidiary({int id, int idCompany, num latitude, num longitude, String company, String name, String description, String address, String croqui}) {
    this._idSubsidiary= id;
    this._idCompany   = idCompany;
    this._latitude    = latitude;
    this._longitude   = longitude;
    this._name        = name;
    this._company     = company;
    this._description = description;
    this._address     = address;
    this._croqui      = croqui;
  } // Subsidiary({int id, int idCompany, num latitude, num longitude, String name, String description, String address}) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  // ignore: missing_return
  factory Subsidiary.fromJson(Map<String, dynamic> data){
    try {
      return Subsidiary(
        id: data['idSubsidiary'],
        idCompany: data['idCompany'],
        company: data['company'],
        name: data['name'],
        description: data['description'],
        address: data['address'],
        latitude: data['location']['latitude'] == null ? null : num.parse(data['location']['latitude']),
        longitude: data['location']['longitude'] == null ? null : num.parse(data['location']['longitude']),
        croqui: data['croqui'],
      );
    }
    catch(error){
      if(config.DEBUG){
        print('[Subsidiary][fromJson] -----------');
        print(error);
        print('[Subsidiary][fromJson] -----------');
      } // if(config.DEBUG){ ... }
    }
  } // factory Subsidiary.fromJson(Map<String, dynamic> data){ ... }

  // ignore: missing_return
  factory Subsidiary.fromDB(Map<String, dynamic> data){
    try {
      return Subsidiary(
        id: data['id_subsidiary'],
        idCompany: data['id_company'],
        company: data['company'],
        name: data['name'],
        description: data['description'],
        address: data['address'],
        latitude: data['latitude'] == null ? null : num.parse(data['latitude']),
        longitude: data['longitude'] == null ? null : num.parse(data['longitude']),
        croqui: data['croqui'],
      );
    }
    catch(error){
      if(config.DEBUG){
        print('[Subsidiary][fromDB] -----------');
        print(error);
        print('[Subsidiary][fromDB] -----------');
      } // if(config.DEBUG){ ... }
    }
  } // factory Subsidiary.fromJson(Map<String, dynamic> data){ ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int get id => this._idSubsidiary;
  int get idCompany => this._idCompany;
  num get latitude => this._latitude;
  num get longitude => this._longitude;
  String get name => this._name;
  String get company => this._company;
  String get description => this._description;
  String get address => this._address;
  String get croqui => this._croqui;

} // class Subsidiary extends ChangeNotifier { ... }