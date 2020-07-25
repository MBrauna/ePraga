import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import './../../components/ePragaField.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
} // class Login extends StatefulWidget { ... }

class _Login extends State<Login> {
  String _usuario, _senha;
  bool bloqueia = false;
  var cpfController = TextEditingController();
  var cpfMask = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
  var senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double logoSize =
        (MediaQuery.of(context).orientation == Orientation.landscape)
            ? (size.height / 4)
            : (size.height / 8);

    return Scaffold(
      key: Key('login'),
      body: Center(
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
                    this._usuario = cpfMask.getUnmaskedText();
                  });
                },
                tipoTeclado: TextInputType.number,
                corBgIcone: Colors.indigo[900],
                corCursor: Colors.indigo[900],
                icone: FaIcon(
                  FontAwesomeIcons.userAlt,
                  color: Colors.white,
                  size: 15.0,
                )
              ),

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
                    this._senha = valor.toString().trim();
                  });
                },
                tipoTeclado: TextInputType.text,
                corBgIcone: Colors.indigo[900],
                corCursor: Colors.indigo[900],
                icone: FaIcon(
                  FontAwesomeIcons.key,
                  color: Colors.white,
                  size: 15.0,
                )
              ),


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
