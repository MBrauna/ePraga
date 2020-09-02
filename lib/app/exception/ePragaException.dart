import 'package:flutter/material.dart';
import 'package:epraga/config/config.dart' as config;

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
      print('---------------------------->> LOG - INIT - EPRAGA EXCEPTION');
      print('[' + this._origin + '] - ' + this._message);
      print('[' + this._origin + '] - ' + this._error.toString());
      print('---------------------------->> LOG - END - EPRAGA EXCEPTION');
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