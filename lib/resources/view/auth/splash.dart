import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import './../../../app/controller/allControllers.dart' as controllers;

class Splash extends StatefulWidget {
  @override
  _Splash createState() =>  _Splash();
} // class Splash extends StatefulWidget { ... }

class _Splash extends State<Splash> {
  @override
  void initState() {
    super.initState();

    controllers.SplashController().determinaLogin().then((value) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(context, value);
      });
    });
  } // void initState(){ ... }


  @override
  Widget build(BuildContext context) {
    Size    size          = MediaQuery.of(context).size;
    double  fonteTitulo   = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 16) : (size.width / 8));
    double  subfonteTitulo= ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 50) : (size.width / 25));
    double  logoSize      = (MediaQuery.of(context).orientation == Orientation.landscape) ? (size.height / 3) : (size.height / 6);

    return Scaffold(
      key: Key('Splash'),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text('ePraga',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'PassionOne',
                  fontSize: fonteTitulo,
                  fontWeight: FontWeight.bold,
                )
              ),

              Container(
                alignment: Alignment.center,
                height: logoSize,
                child: new FlareActor(
                  'assets/logo/splash.flr',
                  animation: 'splash',
                  alignment: Alignment.center,
                  antialias: true,
                  fit: BoxFit.fitHeight,
                )
              ),

              Text('Tec Solution',
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
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _Splash extends State<Splash> { ... }