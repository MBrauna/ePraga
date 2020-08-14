import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:epraga/allFiles.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPage createState() => _UserPage();
} // class UserPage extends StatefulWidget { ... }

class _UserPage extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    Size    size          = MediaQuery.of(context).size;
    double  fonteTitulo   = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 16) : (size.width / 8));
    double  subfonteTitulo= ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 50) : (size.width / 25));
    //double  logoSize      = (MediaQuery.of(context).orientation == Orientation.landscape) ? (size.height / 3) : (size.height / 6);


    return Container(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
      ),
      child: Column(
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


          CardImage(
            image: 'assets/flare/robot.flr',
            animation: 'reposo',
            title: Text(
              context.watch<App>().login.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Código do usuário ' + context.watch<App>().login.user.toString() + '\n' +
              'Última conexão em ' + DateFormat('dd/MM/yyyy kk:mm').format(context.watch<App>().login.lastLogin),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                fontSize: 12.0,
                //color: Theme.of(context).primaryColor,
              ),
            ),
          ),


          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text(
                'Sair do sistema',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
              color: Theme.of(context).errorColor,
              onPressed: () async {
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.remove('lastLogin');
                Navigator.pushReplacement(context, FadePageRoute(LoginPage()));
              },
            ),
          ),

        ],
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _UserPage extends State<UserPage> { ... }