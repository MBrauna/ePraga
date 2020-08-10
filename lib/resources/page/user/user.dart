import 'package:epraga/model/schudule/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../component/cardImage.dart';
import './../../../model/allModels.dart' as models;
import './../../../app/util/fadePageRoute.dart';
import './../../allPages.dart' as views;

class User extends StatefulWidget {
  @override
  _User createState() => _User();
} // class User extends StatelessWidget { ... }

class _User extends State<User> {
  @override
  void initState(){
    super.initState();
  } // void initState() { ... }

  @override
  Widget build(BuildContext context) {
    Size    size          = MediaQuery.of(context).size;

    return Center(
      child: Container(
        //alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            CardImage(
              title: context.watch<models.App>().login == null ? 'Refaça o login' : context.watch<models.App>().login.name,
              subtitle: context.watch<models.App>().login != null ?  'Último login em ${context.watch<models.App>().login.lastLogin.toString()}' : 'Carregando ...',
              image: 'assets/flare/robot.flr',
              animation: 'reposo',
              alert: false,
            ),


            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: RaisedButton(
                  child: Text('Sair'),
                  color: Colors.red[900],
                  textColor: Colors.white,
                  onPressed: () {
                    SharedPreferences.getInstance().then((value){
                      value.remove('dataLogin');
                      context.read<models.App>().database.delete('login');
                      context.read<models.App>().database.delete('schudule');
                      context.read<models.App>().database.delete('task');
                      Navigator.pushReplacement(context, FadePageRoute(views.Login()));
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _User extends State<User> { ... }
