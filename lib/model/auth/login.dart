import 'package:flutter/material.dart';

class Login extends ChangeNotifier {
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  int _id;
  String _name, _hash;
  DateTime _lastLogin;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  Login({int id, String name, String hash, DateTime lastLogin}) {
    if(id == null || id <= 0) {
      this._id = null;
    }
    else {
      this._id = id;
    }

    if (name.trim().length <= 0) {
      this._name = null;
    } // if (name.trim().length <= 0) { ... }
    else {
      this._name = name;
    } // else { ... }

    if (hash.trim().length <= 0) {
      this._hash = null;
    } // if (hash.trim().length <= 0) { ... }
    else {
      this._hash = hash;
    } // else { ... }

    if (lastLogin == null) {
      this._lastLogin = DateTime.now();
    } // if(lastLogin == null){ ... }
    else {
      this._lastLogin = lastLogin;
    } // else { ... }
  }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory Login.fromJson(Map<String, dynamic> data) {
    return Login(
      id: data['id'],
      name: data['name'],
      hash: data['hash'],
      lastLogin: DateTime.fromMillisecondsSinceEpoch(int.parse(data['lastLogin'])),
    );
  } // factory Login.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int get id => this._id;
  String get name => this._name;
  String get hash => this._hash;
  DateTime get lastLogin => this._lastLogin;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set id(int id) {
    if (id == null || id <= 0) {
      this._id = null;
    } // if(id == null || id <= 0) { ... }
    else {
      this._id = id;
    } // else { ... }
  } // set id(int id){ ... }

  set name(String name) {
    if (name.trim().length <= 0) {
      this._name = null;
    } // if (name.trim().length <= 0) { ... }
    else {
      this._name = name;
    } // else { ... }
  } // set name(String name){ ... }

  set hash(String hash) {
    if (hash.trim().length <= 0) {
      this._hash = null;
    } // if (hash.trim().length <= 0) { ... }
    else {
      this._hash = hash;
    } // else { ... }
  } // set hash(String hash){ ... }

  set lastLogin(DateTime date) {
    if (date == null) {
      this._lastLogin = DateTime.now();
    } // if(date == null){ ... }
    else {
      this._lastLogin = date;
    } // else { ... }
  } // set lastLogin(DateTime date) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
}
