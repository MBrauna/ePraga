import 'package:flutter/material.dart';
import 'package:epraga/config/config.dart' as config;

class Login extends ChangeNotifier {

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  num _id;
  String _name, _cpfCnpj, _hash;
  DateTime _lastLogin, _expiredLogin;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  Login();

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  num get id          =>  this._id;
  String get cpfCnpj  =>  this._cpfCnpj;
  String get name     =>  this._name;
  String get hash     =>  this._hash;
  DateTime get last   =>  this._lastLogin;
  DateTime get expire =>  this._expiredLogin;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set id(num data) {
    if(data == null || data <= 0) {
      this._id  = null;
    } // if(data <= 0) { ... }
    else {
      this._id  = data;
    } // else { ... }
    notifyListeners();
  } // set id(num data) { ... }

  set cpfCnpj(String data) {
    if(data == null || data.trim().isEmpty) {
      this._cpfCnpj = null;
    } // if(data.trim().isEmpty) { ... }
    else {
      this._cpfCnpj = data;
    } // else { ... }
    notifyListeners();
  } // set cpfCnpj(num data) { ... }

  set name(String data) {
    if(data == null || data.trim().isEmpty) {
      this._name  = null;
    } // if(data.trim().isEmpty) { ... }
    else {
      this._name  = data;
    } // else { ... }
    notifyListeners();
  } // set name(String data) { ... }

  set hash(String data) {
    if(data == null || data.trim().isEmpty) {
      this._hash  = null;
    } // if(data.trim().isEmpty) { ... }
    else {
      this._hash  = data;
    } // else { ... }
    notifyListeners();
  } // set hash(String data) { ... }

  set last(DateTime date) {
    if(date == null) {
      this._lastLogin = DateTime.now();
    } // if(date == null) { ... }
    else {
      this._lastLogin = date;
    } // else { ... }
    notifyListeners();
  } // set last(DateTime date) { ... }

  set expire(DateTime date) {
    if(date == null) {
      this._expiredLogin  = DateTime.now();
    } // if(date == null) { ... }
    else {
      this._expiredLogin  = date;
    } // else { ... }
    notifyListeners();
  } // set last(DateTime date) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory Login.fromJson(Map<String, dynamic> data) {
    try {
      Login login   = Login();
      login.id      = data['id'];
      login.name    = data['name'];
      login.cpfCnpj = data['cpf_cnpj'];
      login.hash    = data['api_token'];
      login.last    = data['last_login'] == null ? DateTime.now() : DateTime.parse(data['last_login']);
      login.expire  = data['api_expiring'] == null ? DateTime.now() : DateTime.parse(data['api_expiring']);

      return login;
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[LOGIN MODEL]-----');
        print(error);
        print('[LOGIN MODEL]-----');
      } // if(config.DEBUG) { ... }

      return Login();
    } // catch(error) { ... }

  } // factory Login.fromJson(Map<String, dynamic> data) { ... }
} // class Login extends ChangeNotifier { ... }