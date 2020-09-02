import 'package:flutter/material.dart';

class Message {
  BuildContext _context;

  Message(BuildContext context) {
    this._context = context;
  } // Message(BuildContext context) { ...}

  Future error(String message,{int tempo = 10}) {
    try {
      final snackbar = SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: Duration(seconds: tempo),
        backgroundColor: Colors.red,
        key: Key('MessageError'),
      ); // final snacbar = SnackBar( ... );

      Scaffold.of(this._context).showSnackBar(snackbar);
      return null;
    } // try { ... }
    catch (error) {
      return null;
    } // catch(error) { ... }
  } // Future error(String message) { ... }


  Future info(String message,{int tempo = 10}) {
    try {
      final snackbar = SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: Duration(seconds: tempo),
        backgroundColor: Colors.indigo[900],
        key: Key('MessageInfo'),
      ); // final snacbar = SnackBar( ... );

      Scaffold.of(this._context).showSnackBar(snackbar);
      return null;
    } // try { ... }
    catch (error) {
      return null;
    } // catch(error) { ... }
  } // Future error(String message) { ... }

  Future custom(Text conteudo,{int tempo = 10}) {
    try {
      final snackbar = SnackBar(
        content: conteudo,
        duration: Duration(seconds: tempo),
        backgroundColor: Colors.indigo[900],
        key: Key('MessageInfo'),
      ); // final snacbar = SnackBar( ... );

      Scaffold.of(this._context).showSnackBar(snackbar);
      return null;
    } // try { ... }
    catch (error) {
      return null;
    } // catch(error) { ... }
  } // Future custom(Text conteudo,{int tempo = 10}) { ... }
} // class Message { ... }