import 'package:flutter/material.dart';

class ImgSchudule extends ChangeNotifier {

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  String _base64;
  int _idImgSchudule, _idItemSchudule;
  DateTime _createdAt = DateTime.now();

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  ImgSchudule();

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  String get base64       =>  this._base64;
  int get idImgSchudule   =>  this._idImgSchudule;
  int get idItemSchudule  =>  this._idItemSchudule;
  DateTime get createdAt  =>  this._createdAt;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set base64(String data) {
    if(data == null || data.trim().isEmpty) {
      this._base64  = null;
    } // if(data == null || data.trim().isEmpty) { ... }
    else {
      this._base64  = data;
    } // else { ... }
    notifyListeners();
  } // set base64(String data) { ... }

  set idImgSchudule(int data) {
    if(data == null || data <= 0) {
      this._idImgSchudule = null;
    } // if(data == null || data <= 0) { ... }
    else {
      this._idImgSchudule = data;
    } // else { ... }
    notifyListeners();
  } // set idImgSchudule(int data) { ... }

  set idItemSchudule(int data) {
    if(data == null || data <= 0) {
      this._idItemSchudule  = null;
    } // if(data == null || data <= 0) { ... }
    else {
      this._idItemSchudule  = data;
    } // else { ... }
    notifyListeners();
  } // set idItemSchudule(int data) { ... }

  set createdAt(DateTime data) {
    if(data == null) {
      this._createdAt = DateTime.now();
    }
    else {
      this._createdAt = data;
    }
    notifyListeners();
  }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory ImgSchudule.fromJson(Map<String, dynamic> data) {
    ImgSchudule image = ImgSchudule();
    try {
      image.base64          = data['base64'];
      image.idImgSchudule   = data['idImgSchudule'];
      image.idItemSchudule  = data['idItemSchudule'];
      image.createdAt       = data['createdAt'] == null ? DateTime.now() : DateTime.fromMicrosecondsSinceEpoch(data['createdAt']);
    } // try { ... }
    catch(error) {
      print('[ImgSchudule][factory] ---------');
      print(error);
      print('[ImgSchudule][factory] ---------');
    } // catch(error) {  ... }

    return image;
  } // factory ImgSchudule.fromJson(Map<String, dynamic> data) { ... }

} // class ImgSchudule extends ChangeNotifier { ... }