import 'package:epraga/allFiles.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPage createState() => _SplashPage();
} // class SplashPage extends StatefulWidget { ... }

class _SplashPage extends State<SplashPage> {
  bool permissionData = false;

  @override
  void initState(){
    super.initState();
    SplashScreenController.permissions().then((value){
      setState(() {
        permissionData  = value;
      }); // setState(() { .. });
    }); // SplashScreenController.decision().then((value){ ... });
  } // void initState(){ ... }


  @override
  Widget build(BuildContext context) {
    Size    size          = MediaQuery.of(context).size;
    double  fonteTitulo   = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 16) : (size.width / 8));
    double  subfonteTitulo= ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 50) : (size.width / 25));
    double  logoSize      = (MediaQuery.of(context).orientation == Orientation.landscape) ? (size.height / 3) : (size.height / 6);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 15.0,
          right: 15.0,
        ),
        child: Builder(
          builder: (context){

            if(permissionData) {
              Future.delayed(Duration(seconds: 3),(){
                SplashScreenController.getRoute(context);
              }); // Future.delayed(Duration(seconds: 3),(){ ... });
            } // if(permissionData) { ... }

            return Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ePraga',
                      style: TextStyle(
                        fontFamily: 'SystemAnalysis',
                        color: Theme.of(context).primaryColor,
                        fontSize: fonteTitulo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    Text('Tec Solution',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Roboto',
                        fontSize: subfonteTitulo,
                        fontWeight: FontWeight.bold,
                      ),
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
                      ),
                    ),

                  ],
                ),
              ),
            );

          },
        ),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _SplashPage extends State<SplashPage> { ... }