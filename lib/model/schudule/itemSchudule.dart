import 'package:flutter/material.dart';
import './question.dart';
import './imgSchudule.dart';

class ItemSchudule extends ChangeNotifier {
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int _idItemSchudule, _idSchudule, _sequence, _qtdeImages, _spot;
  String _description = '';
  DateTime _lastAlt = DateTime.now();
  List<ImgSchudule> _listImages = List<ImgSchudule>();
  Question _listQuestions  = Question();
  bool _accept  = false, _visit = false;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  ItemSchudule();

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int get idItemSchudule            =>  this._idItemSchudule;
  int get idSchudule                =>  this._idSchudule;
  int get spot                      =>  this._spot;
  int get sequence                  =>  this._sequence;
  int get qtdeImages                =>  this._qtdeImages;
  bool get accept                   =>  this._accept;
  bool get visit                    =>  this._visit;
  String get description            =>  this._description.trim();
  DateTime get lastAlt              =>  this._lastAlt ?? DateTime.now();
  List<ImgSchudule> get listImages  =>  this._listImages ?? List<ImgSchudule>();
  Question get listQuestions        =>  this._listQuestions ?? Question();

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set idSchudule(int data){
    if(data == null || data <= 0){
      this._idSchudule  = null;
    } // if(data == null || data <= 0){ ... }
    else {
      this._idSchudule  = data;
    }
    this._lastAlt = DateTime.now();
    notifyListeners();
  } // set idSchudule(int data){ ... }

  set idItemSchudule(int data) {
    if(data == null || data <= 0) {
      this._idItemSchudule  = null;
    }
    else {
      this._idItemSchudule  = data;
    }
    this._lastAlt = DateTime.now();
    notifyListeners();
  }

  set spot(int data) {
    if(data == null || data <= 0) {
      this._spot  = null;
    } // if(data == null || data <= 0) { ... }
    else {
      this._spot  = data;
    } // else { ... }
    this._lastAlt = DateTime.now();
    notifyListeners();
  }

  set accept(bool data) {
    if(data == null) {
      this._accept  = false;
    }
    else {
      this._accept  = data;
    }
    this._lastAlt = DateTime.now();
    notifyListeners();
  }

  set sequence(int data) {
    if(data == null || data <= 0) {
      this._sequence  = 0;
    }
    else {
      this._sequence  = data;
    }
    this._lastAlt = DateTime.now();
    notifyListeners();
  } // set sequence(int data) { ... }

  set qtdeImages(int data) {
    if(data == null || data <= 0) {
      this._qtdeImages  = 0;
    } // if(data == null || data <= 0) { ... }
    else {
      this._qtdeImages  = data;
    }
    this._lastAlt = DateTime.now();
    notifyListeners();
  } // set qtdeImages(int data) { ... }
  
  set description(String data) {
    if(data == null || data.trim().isEmpty) {
      this._description = 'Sem descrição! Verifique.';
    }
    else {
      this._description = data.trim();
    }
    this._lastAlt = DateTime.now();
    notifyListeners();
  } // set description(String data) { ... }
  
  set lastAlt(DateTime data) {
    if(data == null) {
      this._lastAlt = DateTime.now();
    }  // if(data == null) { ... }
    else {
      this._lastAlt = data;
    }
    this._lastAlt = DateTime.now();
    notifyListeners();
  }
  
  set listImages(List<ImgSchudule> data) {
    if(data == null || data.length <= 0) {
      this._listImages  = List<ImgSchudule>();
    }
    else {
      this._listImages  = data;
    }
    this._lastAlt = DateTime.now();
    notifyListeners();
  }

  set listQuestions(Question data) {
    if(data == null) {
      this._listQuestions = Question();
    }
    else {
      this._listQuestions = data;
    }
    this._lastAlt = DateTime.now();
    notifyListeners();
  }

  set visit(bool data) {
    if(data == null) {
      this._visit = false;
    }
    else {
      this._visit = data;
    }
    this._lastAlt = DateTime.now();
    notifyListeners();
  }
  
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory ItemSchudule.fromJson(Map<String, dynamic> data) {
    ItemSchudule dataReturn = ItemSchudule();
    List<ImgSchudule> listImages  = List<ImgSchudule>();

    if(data['images'] != null) {
      data['images'].forEach((element){
        listImages.add(ImgSchudule.fromJson(element));
      });
    }


    try {
      dataReturn.idItemSchudule = data['idSchuduleItem'];
      dataReturn.idSchudule     = data['idSchudule'];
      dataReturn.visit          = data['visit'];
      dataReturn.spot           = data['spot'];
      dataReturn.description    = data['description'];
      dataReturn.lastAlt        = data['lastAlt'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(data['lastAlt']);
      dataReturn.listImages     = listImages;
      dataReturn.listQuestions  = Question();
      dataReturn.qtdeImages     = data['qtdeImages'];
      dataReturn.sequence       = data['sequence'];
      dataReturn.accept         = data['accept'] ?? false;
    }
    catch(error) {
      print('[ItemSchudule][factory] -------------');
      print(error);
      print('[ItemSchudule][factory] -------------');
    }
    return dataReturn;
  }
}