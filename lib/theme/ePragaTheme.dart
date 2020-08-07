import 'package:flutter/material.dart';

class EpragaTheme {
  /* ****************************************** *
   * ****************************************** */
  static final ThemeData light = ThemeData(
    // Canvas Menu - Coloração
    backgroundColor: Colors.white,
    canvasColor: Colors.white,
    cardColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    // Canvas Principal - Coloração
    primaryColor: Colors.indigo[900],
    accentColor: Colors.green[900],
    disabledColor: Colors.grey,

    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.indigo[900]),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.red,
    ),
  );


  /* ****************************************** *
   * ****************************************** */
  static final ThemeData dark = ThemeData(
    // Canvas Menu - Coloração
    backgroundColor: Colors.white,
    canvasColor: Colors.white,
    cardColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    // Canvas Principal - Coloração
    primaryColor: Colors.indigo[900],
    accentColor: Colors.green[900],
    disabledColor: Colors.grey,

    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.indigo[900]),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.red,
    ),
  );
}