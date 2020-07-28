import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPage createState() => _UserPage();
} // class UserPage extends StatefulWidget { .. }

class _UserPage extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      key: Key('UserPage'),
      padding: EdgeInsets.only(
        top: 10.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 10.0,
            
            color: Colors.white,
            shadowColor: Colors.black,
            child: Text('123'),
          ),
        ],
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _UserPage extends State<UserPage> { ... }
