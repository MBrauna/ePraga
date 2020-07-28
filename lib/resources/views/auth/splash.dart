import 'package:epraga/app/controller/auth/splashController.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
} // class Splash extends StatefulWidget { ... }

class _Splash extends State<Splash> {
  @override
  void initState() {
    super.initState();
  } // void initState(){ ... }

  @override
  Widget build(BuildContext context) {
    SplashController().determinaLogin().then((value) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(context, value);
      });
    });

    Size size = MediaQuery.of(context).size;
    double fonteTitulo    = ((MediaQuery.of(context).orientation == Orientation.landscape)  ? (size.width / 16) : (size.width / 8));
    double subfonteTitulo = ((MediaQuery.of(context).orientation == Orientation.landscape)  ? (size.width / 36) : (size.width / 18));
    double tamanhoLogo    = ((MediaQuery.of(context).orientation == Orientation.landscape)  ? (size.width / 4)  : (size.width - (size.width / 8)));

    return Scaffold(
      key: Key('SplashScreen'),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('ePraga',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Roboto',
                  fontSize: fonteTitulo,
                  fontWeight: FontWeight.bold,
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
              Container(
                alignment: Alignment.center,
                height: tamanhoLogo,
                child: new FlareActor(
                  'assets/logo/splash.flr',
                  animation: 'splash',
                  alignment: Alignment.center,
                  antialias: true,
                  fit: BoxFit.fitHeight,
                )
              ),
            ],
          ),
        ),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class Splash extends StatelessWidget { ... }
