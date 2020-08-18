import 'package:epraga/app/exception/ePragaException.dart';
import 'package:flutter/material.dart';

class Manual extends ChangeNotifier {
  int _id;
  String _title, _body;
  DateTime _manualDate;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --

  Manual({int id, String title, String body, DateTime manualDate}) {
    if(id <= 0 || id == null || id.toString().trim().length <= 0) {
      throw new EPragaException(
        origin: this.runtimeType.toString(),
        error: 'ID não foi informado! Verifique.',
        message: 'ID não foi informado! Verifique.',
      ); // throw new EPragaException( ... );
    } // if(id <= 0 || id == null || id.toString().trim().length <= 0) { ... }
    else {
      this._id  = id;
    }

    if(title.trim().length <= 0) {
      throw new EPragaException(
        origin: this.runtimeType.toString(),
        error: 'Título não encontrado',
        message: 'Título não encontrado',
      ); // throw new EPragaException( ... );
    } // if(title.trim().length <= 0) { ... }
    else {
      this._title = title;
    }

    if(body.trim().length <= 0) {
      throw new EPragaException(
        origin: this.runtimeType.toString(),
        error: 'Corpo não encontrado',
        message: 'Corpo não encontrado',
      ); // throw new EPragaException( ... );
    } // if(title.trim().length <= 0) { ... }
    else {
      this._body = body;
    }

    if(manualDate == null) {
      this._manualDate  = DateTime.now();
    }
    else {
       this._manualDate  = manualDate;
    }
  } // Manual({int id, String title, DateTime manualDate}) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --

  factory Manual.fromJson(Map<String, dynamic> data) {
    return Manual(
      id: data['id'],
      title: data['title'],
      body: data['body'],
      manualDate: data['manualDate'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(data['manualDate']),
    );
  } // factory Manual.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --

  int get id => this._id;
  String get title => this._title;
  String get body => this._body;
  DateTime get createdAt => this._manualDate;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --
}