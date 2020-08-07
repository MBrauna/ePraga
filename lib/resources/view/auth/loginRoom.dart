import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import './../allViews.dart';
import './../../../app/util/fadePageRoute.dart';
import './../../../app/exception/ePragaException.dart';

class LoginRoom extends StatefulWidget {
  String _codeAccess, _password;

  LoginRoom({String codeAccess, String password}) {
    if((codeAccess.length < 11) || (password.length < 3)) {
      throw EPragaException(
        error: 'Não foi possível iniciar a sala de espera! Verifique.',
        message: 'Não foi possível iniciar a sala de espera! Verifique.',
        origin: this.runtimeType.toString()
      );
    }
  } // Login({String codeAccess, String password}) { ... }

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
    Size    size          = MediaQuery.of(context).size;
    //double  logoSize  = (MediaQuery.of(context).orientation == Orientation.landscape) ? (size.height / 3) : (size.height / 6);
    double  subfonteTitulo= ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 50) : (size.width / 25));
    double  logoLoad      = (MediaQuery.of(context).orientation == Orientation.landscape) ? (size.height / 3) : (size.height / 6);


    return Scaffold(
      key: Key('LoginRoom'),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Builder(
        builder: (context) {
          
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
}
