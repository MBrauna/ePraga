import 'package:epraga/resources/components/ePragaField.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import './../../../model/allModels.dart';
import './../../components/ePragaField.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPage createState() => _UserPage();
} // class UserPage extends StatefulWidget { .. }

class _UserPage extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fontLength = (MediaQuery.of(context).orientation == Orientation.landscape) ? (size.width/22) : (size.width/16);
    Login loginData = context.watch<Epraga>().login;

    return new Builder(
      key: Key('UserPage'),
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 15.0,
            right: 15.0,
            bottom: 30.0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: FaIcon(
                  FontAwesomeIcons.solidUserCircle,
                  color: Colors.indigo[900],
                  size: fontLength,
                ),
              ),

              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Center(
                  child: Text(
                    '${loginData.name.toString().trim()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.indigo[900],
                      fontFamily: 'Roboto',
                      fontSize: fontLength,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Último login em ' + DateFormat('dd/MM/yyyy').format(loginData.lastLogin),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.indigo[900],
                      fontFamily: 'Roboto',
                      fontSize: (fontLength/2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              RaisedButton(
                color: Colors.red,
                child: Text(
                  'Desconectar conta',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: (){},
              ),


              Padding(
                padding: EdgeInsets.only(
                  bottom: 30.0,
                  top: 5.0,
                ),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 35.0,
                          child: Center(
                            child: Text(
                              'Alterar senha',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.indigo[900],
                                fontFamily: 'Roboto',
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),

                        EPragaField(
                          height: 20.0,
                          width: double.infinity,
                          prefixIcon: FaIcon(
                            FontAwesomeIcons.key,
                          ),
                          inputType: TextInputType.text,
                          placeholder: 'Informe a senha atual:',
                        ),

                        EPragaField(
                          height: 20.0,
                          width: double.infinity,
                          prefixIcon: FaIcon(
                            FontAwesomeIcons.key,
                          ),
                          inputType: TextInputType.text,
                          placeholder: 'Nova senha:',
                        ),

                        EPragaField(
                          height: 20.0,
                          width: double.infinity,
                          prefixIcon: FaIcon(
                            FontAwesomeIcons.key,
                          ),
                          inputType: TextInputType.text,
                          placeholder: 'Confirme nova senha:',
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Container(
                            color: Colors.indigo[900],
                            child: FlatButton(
                              onPressed: (){},
                              child: Text(
                                'Confirmar alteração de senha',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _UserPage extends State<UserPage> { ... }
