import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './../allViews.dart';

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
      backgroundColor: Colors.grey[200],
      body: Builder(
        builder: (context) => Text('123'),
      ),
      appBar: AppBar(
        
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _MainEpraga extends State<MainEpraga> { ... }
