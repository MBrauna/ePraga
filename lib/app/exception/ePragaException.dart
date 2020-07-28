import 'package:flutter/material.dart';
import './../../config.dart' as config;

class EPragaException implements Exception {
  String _origin;
  dynamic _error;
  String _message;

  EPragaException({
    String origin,
    dynamic error,
    String message = 'Ocorreu  um erro ao executar o procedimento! verifique.',
  }) {
    this._origin = origin ?? this.runtimeType.toString();
    this._error = error;
    this._message = message;

    // Se estivermos no ambiente de debug irá
    if (config.DEBUG) {
      print('[' + this._origin + '] - ' + this._message);
      print('[' + this._origin + '] - ' + this._error.toString());
    } // if(config.DEBUG) { ... }
  } // EPragaException({String origin = '', dynamic error, String message}) { ... }

  void toUser(BuildContext context) {
    final snackbar = SnackBar(
      content: Text(
        '[ERRO] - ' + this._message,
        style: TextStyle(
          backgroundColor: Colors.red,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    Scaffold.of(context).showSnackBar(snackbar);
  } // void toUser(BuildContext context) { ... }
} // class EPragaException implements Exception { ... }
