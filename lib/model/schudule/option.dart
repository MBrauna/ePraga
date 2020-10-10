import 'package:flutter/material.dart';
import './question.dart';

class Option extends ChangeNotifier {
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int _idOption, _idQuestion, _idType, _value;
  String _description, _observation;
  bool _checked;
  DateTime _createdAt;
  List<Question> _listQuestions  = List<Question>();

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  Option();

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int get idOption                  =>  this._idOption;
  int get idQuestion                =>  this._idQuestion;
  int get idType                    =>  this._idType;
  int get value                     =>  this._value;
  String get description            =>  this._description;
  String get observation            =>  this._observation;
  bool get checked                  =>  this._checked ?? false;
  DateTime get createdAt            =>  this._createdAt ??  DateTime.now();
  List<Question> get listQuestions  =>  this._listQuestions ?? List<Question>();

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set idOption(int data) {
    if(data == null || data <= 0) {
      this._idOption  = null;
    } // if(data == null || data <= 0) { ... }
    else {
      this._idOption  = data;
    } // else { ... }
    notifyListeners();
  } // set idOption(int data) { ... }

  set value(int data) {
    if(data == null || data <= 0) {
      this._value = null;
    }
    else {
      this._value = data;
    }
    notifyListeners();
  }

  set idQuestion(int data) {
    if(data == null || data <= 0) {
      this._idQuestion  = null;
    } // if(data == null || data <= 0) { ... }
    else {
      this._idQuestion  = data;
    } // else { ... }
    notifyListeners();
  } // set idQuestion(int data) { ... }

  set idType(int data) {
    if(data == null || data <= 0) {
      this._idQuestion  = 1; // Por default texto
    } // if(data == null || data <= 0) { ... }
    else {
      this._idQuestion  = data;
    } // else { ... }
    notifyListeners();
  } // set idQuestion(int data) { ... }

  set description(String data) {
    if(data == null || data.trim().isEmpty) {
      this._description = 'Sem descrição cadastrada!';
    }
    else {
      this._description = data.trim();
    }
    notifyListeners();
  } // set description(String data) { ... }

  set observation(String data) {
    if(data == null || data.trim().isEmpty) {
      this._observation = null;
    } // if(data == null || data.trim().isEmpty) { ... }
    else {
      this._observation = data.trim();
    } // else { ... }
    notifyListeners();
  } // set observation(String data) { ... }

  set checked(bool data) {
    if(data == null) {
      this._checked = false;
    } // if(data == null) { ... }
    else {
      this._checked = data;
    } // else { ... }
    notifyListeners();
  }

  set createdAt(DateTime data) {
    if(data == null) {
      this._createdAt = DateTime.now();
    } // if(data == null) { ... }
    else {
      this._createdAt = data;
    } // else { ... }
    notifyListeners();
  }

  set listQuestions(List<Question> data){
    if(data == null){
      this._listQuestions = List<Question>();
    }
    else {
      this._listQuestions = data;
    }
  } // set listQuestions(List<Question> data){ ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory Option.fromJson(Map<String, dynamic> data) {
    Option option = Option();
    try{
      option.idOption   = data['idOption'];
      option.idQuestion = data['idQuestion'];
      option.idType     = data['idType'];
      option.description= data['description'];
      option.observation= data['observation'];
      option.checked    = data['checked'];
    }
    catch(error){
      print('[Option][factory] ---------------');
      print(error);
      print('[Option][factory] ---------------');
    }

    return option;
  } // factory Option.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
} // class Option extends ChangeNotifier { ... }