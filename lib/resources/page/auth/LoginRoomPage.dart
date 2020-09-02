import 'package:epraga/allFiles.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginRoomPage extends StatefulWidget {
  String usuario, senha;
  LoginRoomPage(this.usuario, this.senha);

  @override
  _LoginRoomPage createState() => _LoginRoomPage();
} // class LoginRoomPage extends StatefulWidget { ... }

class _LoginRoomPage extends State<LoginRoomPage> {
  bool execValidate = false;

  @override
  void initState(){
    super.initState();
  } // void initState(){ ... }

  @override
  Widget build(BuildContext context) {
    Size    size            = MediaQuery.of(context).size;
    double  fonteTitulo     = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 16) : (size.width / 8));
    double  subfonteTitulo  = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 50) : (size.width / 25));
    double  logoLoad        = (MediaQuery.of(context).orientation == Orientation.landscape) ? (size.height / 3) : (size.height / 6);

    if(!execValidate) {
      // Marca como já executado
      setState(() {
        execValidate = true;
      });
      // Executa o método e aguarda a finalização
      LoginController.requestLogin(context, widget.usuario, widget.senha);
    } // if(!execValidate) { ... }

    return Scaffold(
      body: Builder(
        builder: (context){

          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text('ePraga',
                    style: TextStyle(
                      fontFamily: 'SystemAnalysis',
                      color: Theme.of(context).primaryColor,
                      fontSize: fonteTitulo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),



                  Text(
                    'Tec Solution',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'Roboto',
                      fontSize: subfonteTitulo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),



                  Container(
                    height: logoLoad,
                    child: new FlareActor(
                      'assets/flare/robot.flr',
                      animation: 'Cargando',
                    ),
                  ),



                  Text(
                    '\nAguarde, carregando o sistema.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'Roboto',
                      fontSize: subfonteTitulo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),


                ],
              ),
            )
          );

        },
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _LoginRoomPage extends State<LoginRoomPage> { ... }