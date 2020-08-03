import 'package:epraga/app/controller/auth/loginController.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../../../app/controller/util/networkController.dart';
import './../../../app/util/message.dart';
import './../../allViews.dart';
import './../../../model/ePraga.dart';
import './../../../app/util/fadePageRoute.dart';

class WaitRoom extends StatefulWidget {
  String _user, _password;

  WaitRoom(String user, String password) {
    this._user = user;
    this._password = password;
  } // WaitRoom(String _user, String _password) { ... }

  @override
  _WaitRoom createState() => _WaitRoom();
} // class WaitRoom extends StatefulWidget { ... }

class _WaitRoom extends State<WaitRoom> {
  String messageLoading = 'Verificando rede';

  @override
  void initState() {
    super.initState();
    NetworkController(context).verify().then((value){
      if(value){
        setState(() {
          messageLoading = 'Obtendo dados do login';
        });

        LoginController().getLogin(int.parse(widget._user), widget._password).then((value){
          setState(() {
            messageLoading = 'Atualizando dados!';
          });

          if(value.containsKey('error')) {
            Navigator.pushReplacement(context, FadePageRoute(Login(message: value['error'],)));
          }
          else if(value.containsKey('code') && value.containsKey('access') && value['code'] == 200 && value['access'].length > 0){
            // Se tudo ocorreu bem então marca para iniciar o login
            context.read<Epraga>().access = value['access'];
            context.read<Epraga>().login  = value['login'];
            Navigator.pushReplacement(context, FadePageRoute(MainEpraga()));
          }
          else {
            Navigator.pushReplacement(context, FadePageRoute(Login(message: 'Não foi possível realizar o login! Tente novamente após alguns minutos.',)));
          }
        });
      } // if(value){ ... }
      else {
        Navigator.pushReplacement(context, FadePageRoute(Login(message: 'A operação atual exige conexão com rede de internet! Verifique.',)));
      }
    }); // NetworkController(context).verify().then((value){ ... }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fonteTitulo    = ((MediaQuery.of(context).orientation == Orientation.landscape)  ? (size.width / 28) : (size.width / 14));
    double logoSize = (MediaQuery.of(context).orientation == Orientation.landscape) ? (size.height / 3) : (size.height / 6);
    
    return Scaffold(
      key: Key('WaitRoom'),
      body: Builder(
        builder: (context) => Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: logoSize,
                  child: new FlareActor(
                    'assets/logo/splash.flr',
                    animation: 'splash',
                    alignment: Alignment.center,
                  ),
                ),
                Center(
                  child: Text('${messageLoading.trim()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Roboto',
                      fontSize: fonteTitulo,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _WaitRoom extends State<WaitRoom> { ... }
