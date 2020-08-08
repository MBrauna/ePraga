import 'package:flutter/material.dart';

import './../../components/connectivity.dart';
import './../../components/cardImage.dart';

class User extends StatefulWidget {
  @override
  _User createState() => _User();
} // class User extends StatelessWidget { ... }

class _User extends State<User> {
  @override
  void initState() {
    super.initState();
  } // void initState() { ... }

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Connectivity(),

          CardImage(
            title: 'Michel Brauna Rodrigues de sapopemba teste',
            subtitle: 'Token de acesso\nVocê está acessando com esse token abaixo\n\n\n\n\n\n\n testetetahsjkdhajkshdjkahskdjhasjlkdhajhs',
            image: 'assets/flare/robot.flr',
            animation: 'reposo',
            alert: false,
          ),
          Text('123', style: TextStyle(color: Colors.red),),
          
          Text('123', style: TextStyle(color: Colors.red),),
          
          Text('123', style: TextStyle(color: Colors.red),),
          
        ],
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _User extends State<User> { ... }
