import 'package:epraga/resources/view/auth/loginRoom.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import './../../../app/util/message.dart';
import './../../components/ePragaField.dart';
import './../../../app/util/fadePageRoute.dart';
import './../allViews.dart';

// -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

class Login extends StatefulWidget {
  String _message;

  Login({String message = ''}) {
    if(message.trim().isEmpty) {
      this._message = null;
    } // if(message.trim().isEmpty) { ... }
    else {
      this._message = message.trim();
    } // else { ... }
  } // Login({String message}) { ... }

  @override
  _Login createState() => _Login();
} // class Login extends StatefulWidget { ... }

// -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

class _Login extends State<Login> {
  // ------------ # DADOS INTERNOS # ------------ //
  bool    _blockField = false;
  String  _codeAccess, _password;
  TextEditingController _cpfController  = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  MaskTextInputFormatter  _cpfMask = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
  // ------------ # DADOS INTERNOS # ------------ //

  @override
  void initState() {
    super.initState();
  } // void initState() { ... }


  void _validateLogin(BuildContext context) {
    try {
      if((this._password == null || this._codeAccess == null || this._password.length < 3) || (this._codeAccess.length < 11)) {
        Message(context).error('Dados não foram preenchidos corretamente! Verifique.');
        return;
      }

      Navigator.pushReplacement(context, FadePageRoute(
        LoginRoom(
          codeAccess: this._codeAccess.trim(),
          password: this._password.trim(),
        ),
      ));
    }
    catch(erro) {
      Message(context).error('Não foi possível validar os dados de login! Verifique.');
    }
  } // void _validateLogin() { ... }



  @override
  Widget build(BuildContext context) {
    Size    size        = MediaQuery.of(context).size;
    double  logoSize    = (MediaQuery.of(context).orientation == Orientation.landscape) ? (size.height / 3) : (size.height / 6);
    double  fonteTitulo = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 16) : (size.width / 8));

    return Scaffold(
      key: Key('Login'),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Builder(
        builder: (context) {
          if(widget._message != null){
            Message(context).error(widget._message);
            widget._message = null;
          }

          return Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
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
                    height: logoSize,
                    child: new FlareActor(
                      'assets/logo/splash.flr',
                      animation: 'splash',
                      alignment: Alignment.center,
                    ),
                  ),
                  
                  
                  EPragaField(
                    width: double.infinity,
                    height: 40.0,
                    inputType: TextInputType.number,
                    prefixIcon: FaIcon(
                      FontAwesomeIcons.userAlt,
                    ),
                    accentColor: Theme.of(context).primaryColor,
                    autocorrect: false,
                    autofocus: true,
                    backgroundColor: Theme.of(context).backgroundColor,
                    controller: this._cpfController,
                    mask: this._cpfMask,
                    cornerRadius: BorderRadius.only(
                      bottomRight: Radius.circular(2.0),
                      topRight: Radius.circular(2.0),
                    ),
                    duration: Duration(milliseconds: 200),
                    enabled: !this._blockField,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    maxLines: 1,
                    minLines: 1,
                    obscureText: false,
                    isShadow: true,
                    onChanged: (valor) {
                      setState(() {
                        this._codeAccess = this._cpfMask.getUnmaskedText();
                      });
                    },
                    placeholder: 'Usuário',
                    textColor: Theme.of(context).primaryColor,
                  ),
                  
                  
                  
                  EPragaField(
                    width: double.infinity,
                    height: 40.0,
                    inputType: TextInputType.text,
                    prefixIcon: FaIcon(
                      FontAwesomeIcons.key,
                    ),
                    accentColor: Theme.of(context).primaryColor,
                    autocorrect: false,
                    autofocus: true,
                    backgroundColor: Theme.of(context).backgroundColor,
                    controller: this._passwordController,
                    cornerRadius: BorderRadius.only(
                      bottomRight: Radius.circular(2.0),
                      topRight: Radius.circular(2.0),
                    ),
                    duration: Duration(milliseconds: 200),
                    enabled: !this._blockField,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    maxLines: 1,
                    minLines: 1,
                    obscureText: true,
                    isShadow: true,
                    onChanged: (valor) {
                      setState(() {
                        this._password = this._passwordController.text;
                      });
                    },
                    placeholder: 'Senha',
                    textColor: Theme.of(context).primaryColor,
                  ),




                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: RaisedButton(
                        child: Text('Acessar ePraga'),
                        color: Colors.indigo[900],
                        textColor: Colors.white,
                        onPressed: () {
                          this._validateLogin(context);
                        },
                      ),
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
} // class _Login extends State<Login> { ... }