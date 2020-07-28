import 'package:flutter/material.dart';

class EpragaTheme {
  EpragaTheme._();

  /* ****************************************** *
  *  ****************************************** */
  static final ThemeData light = ThemeData(
    accentColor: Colors.indigo[900],
    accentColorBrightness: Brightness.light,
    accentIconTheme: IconThemeData(
      color: Colors.indigo[900],
      opacity: 1.0,
    ),
    accentTextTheme: TextTheme(),
    appBarTheme: AppBarTheme(
      color: Colors.indigo[900],
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    applyElevationOverlayColor: true,
    backgroundColor: Colors.white,
    bannerTheme: MaterialBannerThemeData(),
    bottomAppBarColor: Colors.indigo[900],
    brightness: Brightness.light,
    buttonColor: Colors.indigo[900],
    buttonTheme:  ButtonThemeData(
      alignedDropdown: true,
      buttonColor: Colors.indigo[900],
      disabledColor: Colors.indigo[100],
      height: 30.0,
      focusColor: Colors.indigoAccent[700],
      highlightColor: Colors.indigoAccent[700],
      hoverColor: Colors.indigoAccent[700],
      minWidth: double.infinity,
      padding: EdgeInsets.only(
        bottom: 5.0,
        top: 5.0,
        left: 15.0,
        right: 15.0,
      ),
    ),
    canvasColor: Colors.white,
    cardColor: Colors.white,
    cardTheme: CardTheme(
      color: Colors.white70,
      elevation: 10.0,
      shadowColor: Colors.black,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white10,
      primaryVariant: Colors.white38,
      secondary: Colors.white70,
    ),
    cursorColor: Colors.indigo[900],
    disabledColor: Colors.indigo[100],
    errorColor: Colors.red,
    fontFamily: 'Roboto',
    iconTheme: IconThemeData(
      color: Colors.indigo[900],
    ),
    primaryColor: Colors.indigo[900],
  );
  /*
  */
  static final ThemeData dark = ThemeData(
    accentColor: Colors.indigo[900],
    accentColorBrightness: Brightness.dark,
    accentIconTheme: IconThemeData(
      color: Colors.indigo[900],
      opacity: 1.0,
    ),
    accentTextTheme: TextTheme(),
    appBarTheme: AppBarTheme(
      color: Colors.indigo[900],
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    applyElevationOverlayColor: true,
    backgroundColor: Colors.indigo[50],
    bannerTheme: MaterialBannerThemeData(),
    bottomAppBarColor: Colors.indigo[900],
    brightness: Brightness.light,
    buttonColor: Colors.indigo[900],
    buttonTheme:  ButtonThemeData(
      alignedDropdown: true,
      buttonColor: Colors.indigo[900],
      disabledColor: Colors.indigo[100],
      height: 30.0,
      focusColor: Colors.indigoAccent[700],
      highlightColor: Colors.indigoAccent[700],
      hoverColor: Colors.indigoAccent[700],
      minWidth: double.infinity,
      padding: EdgeInsets.only(
        bottom: 5.0,
        top: 5.0,
        left: 15.0,
        right: 15.0,
      ),
    ),
    canvasColor: Colors.white,
    cardColor: Colors.white,
    cardTheme: CardTheme(
      color: Colors.white70,
      elevation: 10.0,
      shadowColor: Colors.black,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white10,
      primaryVariant: Colors.white38,
      secondary: Colors.white70,
    ),
    cursorColor: Colors.indigo[900],
    disabledColor: Colors.indigo[100],
    errorColor: Colors.red,
    fontFamily: 'Roboto',
    iconTheme: IconThemeData(
      color: Colors.indigo[900],
    ),
    primaryColor: Colors.white,
  );
} // class Light { ... }
