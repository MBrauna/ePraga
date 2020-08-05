import 'package:flutter/foundation.dart';
import './../../app/exception/ePragaException.dart';

class Access extends ChangeNotifier with DiagnosticableTreeMixin {
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  int _id;
  String _name, _description, _hash;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  Access({int id, String name, String description, String hash}) {
    try {
      if (name.trim().isNotEmpty) {
        this._name = name;
      }

      if (id.toString().trim().isNotEmpty) {
        this._id = id;
      } // if(id.toString().trim().isNotEmpty) { ... }

      if (description.trim().isNotEmpty) {
        this._description = description;
      } // if(description.trim().isNotEmpty) { ... }

      if (hash.trim().isNotEmpty) {
        this._hash = hash;
      } // if(hash.trim().isNotEmpty) { ... }
    } // try { ... }
    catch (erro) {
      throw new EPragaException(
          error: erro,
          message: 'Não foi possível inicializar a classe [ACCESS]! Verifique.',
          origin: this.runtimeType.toString());
    } // catch(erro) { ... }
  } // Access({int id, String description, String hash}) { ... }

  factory Access.fromJson(Map<String, dynamic> value) {
    return Access(
      id: value['id'],
      name: value['name'],
      description: value['description'],
      hash: value['hash'],
    );
  } // factory Access.fromJson(Map<String, dynamic> value) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  int get id => this._id;
  String get name => this._name;
  String get description => this._description;
  String get hash => this._hash;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
  set id(int id) {
    try {
      if (id.toString().trim().isNotEmpty) {
        this._id = id;
        notifyListeners();
      } // if(id.toString().trim().isNotEmpty) { ... }
      else {
        throw Exception('Parâmetro inválido! Verifique.');
      } // else { ... }
    } // try { ... }
    catch (erro) {
      throw new EPragaException(
          error: erro,
          message:
              'Não foi possível inicializar a classe [ACCESS][ID]! Verifique.',
          origin: this.runtimeType.toString());
    } // catch(erro){ ... }
  } // set id(int id){ ... }

  set name(String name) {
    try {
      if (name.trim().isNotEmpty) {
        this._name = name;
        notifyListeners();
      } // if(name.trim().isNotEmpty) { ... }
      else {
        throw Exception('Parâmetro inválido! Verifique.');
      } // else { ... }
    } // try { ... }
    catch (erro) {
      throw new EPragaException(
          error: erro,
          message:
              'Não foi possível inicializar a classe [ACCESS][NAME]! Verifique.',
          origin: this.runtimeType.toString());
    } // catch(erro){ ... }
  } // set name(String name) { ... }

  set description(String description) {
    try {
      if (description.trim().isNotEmpty) {
        this._description = description;
        notifyListeners();
      } // if(description.trim().isNotEmpty) { ... }
      else {
        throw Exception('Parâmetro inválido! Verifique.');
      } // else { ... }
    } // try { ... }
    catch (erro) {
      throw new EPragaException(
          error: erro,
          message:
              'Não foi possível inicializar a classe [ACCESS][DESCRIPTION]! Verifique.',
          origin: this.runtimeType.toString());
    } // catch(erro){ ... }
  } // set description(String description) { ... }

  set hash(String hash) {
    try {
      if (hash.trim().isNotEmpty) {
        this._hash = hash;
        notifyListeners();
      } // if(hash.trim().isNotEmpty) { ... }
      else {
        throw Exception('Parâmetro inválido! Verifique.');
      } // else { ... }
    } // try { ... }
    catch (erro) {
      throw new EPragaException(
          error: erro,
          message:
              'Não foi possível inicializar a classe [ACCESS][HASH]! Verifique.',
          origin: this.runtimeType.toString());
    } // catch(erro){ ... }
  } // set description(String description) { ... }
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
}
