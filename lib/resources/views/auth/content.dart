import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import './../../components/ePragaField.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
} // class Login extends StatefulWidget { ... }

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  height: (size.height / 6),
                  child: new FlareActor(
                    'assets/logo/splash.flr',
                    animation: 'splash',
                    alignment: Alignment.center,
                    antialias: true,
                    fit: BoxFit.fitHeight,
                  )),
              EPragaField(
                  campoAlto: 1.0,
                  campoBaixo: 1.0,
                  campoDireita: 15.0,
                  campoEsquerda: 15.0,
                  texto: 'Usuário',
                  controlador: cpfController,
                  mascara: cpfMask,
                  leitura: bloqueia,
                  fncEdicao: (valor) {
                    setState(() {
                      this.usuario = cpfMask.getUnmaskedText();
                    });
                  },
                  tipoTeclado: TextInputType.number,
                  corBgIcone: Colors.indigo[900],
                  corCursor: Colors.indigo[900],
                  icone: FaIcon(
                    FontAwesomeIcons.userAlt,
                    color: Colors.white,
                    size: 15.0,
                  )),
              EPragaField(
                  campoAlto: 1.0,
                  campoBaixo: 1.0,
                  campoDireita: 15.0,
                  campoEsquerda: 15.0,
                  controlador: senhaController,
                  texto: 'Senha',
                  leitura: bloqueia,
                  senha: true,
                  fncEdicao: (valor) {
                    setState(() {
                      senha = valor.toString().trim();
                    });
                  },
                  tipoTeclado: TextInputType.text,
                  corBgIcone: Colors.indigo[900],
                  corCursor: Colors.indigo[900],
                  icone: FaIcon(
                    FontAwesomeIcons.key,
                    color: Colors.white,
                    size: 15.0,
                  )),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: RaisedButton(
                    child: Text('Acessar ePraga'),
                    color: Colors.indigo[900],
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _Login extends State<Login> { ... }
