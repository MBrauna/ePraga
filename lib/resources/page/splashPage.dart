import 'package:epraga/allFiles.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPage createState() => _SplashPage();
} // class SplashPage extends StatefulWidget { ... }

class _SplashPage extends State<SplashPage> {
  bool _permissionData = false;

  @override
  // ignore: must_call_super
  void initState(){
    SplashScreenController.permissions().then((value){
        setState((){
          this._permissionData  = value;
        });
    }); // SplashScreenController.decision().then((value){ ... });
  } // void initState(){ ... }

  @override
  Widget build(BuildContext context) {
    Size    size          = MediaQuery.of(context).size;
    double  fonteTitulo   = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 16) : (size.width / 8));
    double  subfonteTitulo= ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 50) : (size.width / 25));
    double  logoSize      = (MediaQuery.of(context).orientation == Orientation.landscape) ? (size.height / 3) : (size.height / 6);

    return Scaffold(
      key: Key('SplashPage'),
      body: Builder(
        builder: (context){

          if(this._permissionData) {
            Future.delayed(Duration(seconds: 3),(){
              SplashScreenController.getRoute(context);
            }); // Future.delayed(Duration(seconds: 3),(){ ... });
          } // if(permissionData) { ... }
          
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15.0,
              ),
              scrollDirection: Axis.vertical,
              child: Column(
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
        }
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _SplashPage extends State<SplashPage> { .. }