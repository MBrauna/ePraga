import 'package:flutter/material.dart';

class Mobile extends ChangeNotifier {
  Map<String, dynamic>  _platform;
  List<String>          _phone, _imei;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  List<String>          get imei      =>  this._imei;
  Map<String, dynamic>  get platform  =>  this._platform;
  List<String>          get phone     =>  this._phone;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set imei(List<String> data) {
    if(data.length <= 0) {
      this._imei  = List<String>();
    } // if(data.length <= 0) { ... }
    else {
      this._imei  = data;
    } // else { ... }
    notifyListeners();
  } // set imei(List<String> data) { ... }


  set platform(Map<String, dynamic> data) {
    this._platform  = data;
    notifyListeners();
  } // set platform(Map<String, dynamic> data) { ... }


  set phone(List<String> data) {
    if(data.length <= 0) {
      this._phone = List<String>();
    } // if(data.length <= 0) { ... }
    else {
      this._phone = data;
    } // else { ... }
    notifyListeners();
  } // set phone(List<String> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
} // class Mobile extends ChangeNotifier { ... }