import 'package:epraga/app/exception/ePragaException.dart';
import 'package:flutter/material.dart';

class Guide extends ChangeNotifier {
  int _id;
  String _title, _body;
  DateTime _guideDate;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --

  Guide({int id, String title, String body, DateTime guideDate}) {
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

    if(guideDate == null) {
      this._guideDate  = DateTime.now();
    }
    else {
       this._guideDate  = guideDate;
    }
  } // Guide({int id, String title, DateTime guideDate}) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --

  factory Guide.fromJson(Map<String, dynamic> data) {
    return Guide(
      id: data['id'],
      title: data['title'],
      body: data['body'],
      guideDate: data['guideDate'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(data['guideDate']),
    );
  } // factory Manual.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --

  int get id => this._id;
  String get title => this._title;
  String get body => this._body;
  DateTime get createdAt => this._guideDate;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # --
}