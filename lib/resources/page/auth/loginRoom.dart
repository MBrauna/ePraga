import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import './../../../app/controller/LoginRoomController.dart';

// ignore: must_be_immutable
class LoginRoom extends StatefulWidget {
  String accessCode, password;
  LoginRoom({this.accessCode, this.password});

  @override
  _LoginRoom createState() => _LoginRoom();
} // class LoginRoom extends StatefulWidget { ... }

class _LoginRoom extends State<LoginRoom> {
  @override
  void initState() {
    super.initState();
  } // void initState() { ... }

  @override
  Widget build(BuildContext context) {
    Size    size            = MediaQuery.of(context).size;
    double  subfonteTitulo  = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 50) : (size.width / 25));
    double  logoLoad        = (MediaQuery.of(context).orientation == Orientation.landscape) ? (size.height / 3) : (size.height / 6);

    LoginRoomController.getDecision(context, widget.accessCode, widget.password);

    return Scaffold(
      body: Builder(
        builder: (context){

          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: logoLoad,
                    child: new FlareActor(
                      'assets/flare/robot.flr',
                      animation: 'Cargando',
                    ),
                  ),


                  Text('Validando o login!\nAguarde.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Roboto',
                      fontSize: subfonteTitulo,
                      fontWeight: FontWeight.bold,
                    )
                  ),


                ],
              ),
            ),
          );

        },
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _LoginRoom extends State<LoginRoom> { ... }