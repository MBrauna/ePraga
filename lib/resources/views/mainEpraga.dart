import 'package:flutter/material.dart';

class MainEpraga extends StatefulWidget {
  @override
  _MainEpraga createState() => _MainEpraga();
} // class MainEpraga extends StatefulWidget { ... }

class _MainEpraga extends State<MainEpraga> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   
    return Scaffold(
      extendBody: true,
      body: Builder(
        builder: (context) => Text('123'),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _MainEpraga extends State<MainEpraga> { ... }
