import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import './../../components/ePragaField.dart';
import './../../../app/util/message.dart';
import './../../allViews.dart';
import './../../../app/util/fadePageRoute.dart';

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

class _Login extends State<Login> {
  String _user, _password;
  bool _blockField = false, _blockButton  = false;
  TextEditingController _cpfController      = TextEditingController(),
                        _passwordController = TextEditingController();
  MaskTextInputFormatter  _cpfMask = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});

  void _requestLogin(BuildContext context) {
    if(!this._blockButton || this._password == null || this._user == null) {
      Message(context).error('Preencha os dados corretamente');
      return;
    } // if(!this._blockButton) { ... }
    else {
      Navigator.pushReplacement(context, FadePageRoute(WaitRoom(this._user.trim(),this._password.trim())));
    } // else { ... }
  } // void _requestLogin(BuildContext context) { ... }

  @override
  void initState() {
    super.initState();
  } // void initState() { ... }

  @override
  Widget build(BuildContext context) {
    Size size       = MediaQuery.of(context).size;
    double logoSize = (MediaQuery.of(context).orientation == Orientation.landscape) ? (size.height / 3) : (size.height / 6);

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
                        this._user = this._cpfMask.getUnmaskedText();
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
                          if((this._passwordController.text.length < 3) || (this._cpfMask.getUnmaskedText().length < 11)) {
                            setState(() {
                              this._blockButton = false;
                            });
                          } // if(this._passwordController.text.trim().length < 3) { ... }
                          else {
                            this._blockButton = true;
                          } // else { ... }

                          this._requestLogin(context);
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
