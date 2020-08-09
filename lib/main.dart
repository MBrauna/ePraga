import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './bootstrap/ePraga.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(EPraga());
}
