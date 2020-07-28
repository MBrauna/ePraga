import 'package:flutter/material.dart';

class Message {
  BuildContext _context;

  Message(BuildContext context) {
    this._context = context;
  } // Message(BuildContext context) { ...}

  Future error(String message) {
    try {
      final snackbar = SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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


  Future info(String message) {
    try {
      final snackbar = SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
} // class Message { ... }
