import 'package:epraga/app/exception/ePragaException.dart';
import 'package:flutter/material.dart';

class Login extends ChangeNotifier {
  
  bool _mobileAccess;
  DateTime _lastLogin, _expiredLogin;
  int _id;
  String _name, _identity, _email, _device, _token;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  Login({bool mobileAccess = false, DateTime lastLogin, DateTime expiredLogin, int id, String name, String identity, String email, String device, String token,}){
    this._mobileAccess = mobileAccess;
    if(lastLogin == null) {
      this._lastLogin = DateTime.now();
    } // if(lastLogin == null) { ... }
    else {
      this._lastLogin = lastLogin;
    } // else { ... }

    if(expiredLogin == null) {
      this._expiredLogin = DateTime.now();
    } // if(expiredLogin == null) { ... }
    else {
      this._expiredLogin = expiredLogin;
    } // else { ... }

    if(id == null || id <= 0) {
      new EPragaException(
        error: '[ID] - Código do usuário está inválido! Verifique.',
        message: '[ID] - Código do usuário está inválido! Verifique.',
        origin: this.runtimeType.toString(),
      );
    } // if(id == null || id <= 0) { ... }
    else {
      this._id  = id;
    } // else { ... }

    if(token.trim().isEmpty || token == null) {
      new EPragaException(
        error: '[TOKEN] - Código do token não foi informado! Verifique.',
        message: '[TOKEN] - Código do token não foi informado! Verifique.',
        origin: this.runtimeType.toString(),
      );
    } // if(token.trim().isEmpty || token == null) { ... }
    else {
      this._token = token;
    }

    this._name = name;
    this._identity = identity;
    this._email = email;
    this._device  = device;
  } //  Login({bool mobileAccess, DateTime lastLogin, DateTime expiredLogin, int id, String name, String identity, String email, String device, String token,}){ ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory Login.fromJson(Map<String, dynamic> data) {
    return Login(
      device: data['mobile_device'],
      email: data['email'],
      expiredLogin: data['api_expiring'] == null ? null : DateTime.parse(data['api_expiring']),
      id: data['id'],
      identity: data['cpf_cnpj'],
      lastLogin: data['last_login'] == null ? null : DateTime.parse(data['last_login']),
      mobileAccess: data['mobile_access'] ?? false,
      name: data['name'],
      token: data['api_token'],
    );
  } // factory Login.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  bool get mobileAccess => this._mobileAccess;
  int get id => this._id;
  String get name => this._name;
  String get identity => this._identity;
  String get email => this._email;
  String get device => this._device;
  String get token => this._token;
  DateTime get lastLogin => this._lastLogin;
  DateTime get expiredLogin => this._expiredLogin;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
}