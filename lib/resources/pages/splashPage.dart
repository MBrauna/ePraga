import 'dart:io';
import 'package:epraga/allFiles.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPage createState() => _SplashPage();
} // class SplashPage extends StatefulWidget { ... }

class _SplashPage extends State<SplashPage> {
  bool _execPermission  = false;
  bool _firstExec       = true;
  bool _withoutPerm     = true;

  @override
  void initState(){
    super.initState();
    SplashController.permissions().then((perm){
      setState(() {
        _execPermission = perm;
        _withoutPerm    = perm;
      });
    }); // SplashController.permissions().then((perm){ ... }
  } // void initState(){ ... }


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double fonteTitulo  = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 16) : (size.width / 8));
    double subfonteTitulo = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 50) : (size.width / 25));
    double logoSize = (MediaQuery.of(context).orientation == Orientation.landscape) ? (size.height / 3) : (size.height / 6);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: Key('Splash'),
      extendBody: true,
      body: Builder(
        builder: (ctx){

          if(!this._withoutPerm) {
            Message(ctx).error('Uma ou mais permissões não foram concebidas! Verifique.',tempo: 5);

            Future.delayed(Duration(seconds: 3),(){
              // Finaliza a aplicação
              if(Platform.isIOS){
                SystemNavigator.pop();
              } // if(Platform.isIOS){ ... }
              else {
                exit(0);
              } // else { ... }
            });
          } // if(!this._withoutPerm) { ... }

          if(this._firstExec && this._execPermission) {
            // Marca como falso a primeira execução
            _firstExec = false;

            // Aguarda 3 segundos para execução
            Future.delayed(Duration(seconds: 3),(){
              SplashController.getRoute(ctx);
            });
          } // if(this._firstExec && this._execPermission) { ... }

          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                left: 15.0,
                right: 15.0,
              ),
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
                      'assets/animation/logo.flr',
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
    );
  } // Widget build(BuildContext context) { ... }
} // class _SplashPage extends State<SplashPage> { ... }