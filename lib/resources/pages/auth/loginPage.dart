import 'package:epraga/allFiles.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {

  String message;
  LoginPage({this.message});

  @override
  _LoginPage createState() => _LoginPage();
} // class MainPage extends StatefulWidget { ... }

class _LoginPage extends State<LoginPage> {
  // ------------ # DADOS INTERNOS # ------------ //
  bool    _blockField = false;
  String  _codeAccess, _password;
  TextEditingController _cpfController  = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  MaskTextInputFormatter  _cpfMask = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
  // ------------ # DADOS INTERNOS # ------------ //

  void _validateLogin(BuildContext context) {
    try {
      VerifyNetwork().verify().then((connected){
        if(!connected) {
          Message(context).error('[ATENÇÃO] Você está offline! Para realizar esta operação é necessária conexão com a internet.',tempo: 2);
          return;
        } // if(!connected) { ... }

        if(this._codeAccess == null) {
          Message(context).error('[ATENÇÃO] Código do usuário não foi preenchido!',tempo: 2);
          return;
        } // if(this._codeAccess == null) { ... }

        if(this._codeAccess.length < 11) {
          Message(context).error('[ATENÇÃO] Código do usuário está fora do padrão esperado! Verifique.',tempo: 2);
          return;
        } // if(this._codeAccess.length < 11) { ... }

        if(this._password == null) {
          Message(context).error('[ATENÇÃO] Senha não foi preenchida!',tempo: 2);
          return;
        } // if((this._password == null) || (this._password.length < 3)) { ... }

        if(this._password.length <= 3) {
          Message(context).error('[ATENÇÃO] Senha está fora do padrão esperado! Verifique.',tempo: 2);
          return;
        } // if(this._password.length <= 3) { ... }

        if(CPFValidator.validate(this._codeAccess)) {
          Navigator.pushReplacement(context, FadePageRoute(LoginRoomPage(this._codeAccess, this._password)));
          return;
        } // if(CPFValidator.validate(this._codeAccess)) { ... }
        else {
          Message(context).error('[ATENÇÃO] O CPF informado é inválido! Verifique.',tempo: 2);
          return;
        } // else { ... }

      });
    }
    catch(erro) {
      Message(context).error('[ERRO] Não foi possível validar o acesso!',tempo: 2);
      return;
    }
  } // void _validateLogin() { ... }

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    double fonteTitulo  = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 16) : (size.width / 8));
    double logoSize = (MediaQuery.of(context).orientation == Orientation.landscape) ? (size.height / 3) : (size.height / 6);


    return Scaffold(
      key: Key('LoginPage'),
      backgroundColor: Theme.of(context).backgroundColor,
      extendBody: true,
      body: Builder(
        builder: (ctx) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: logoSize,
                    child: new FlareActor(
                      'assets/animation/logo.flr',
                      animation: 'splash',
                      alignment: Alignment.center,
                      antialias: true,
                      fit: BoxFit.fitHeight,
                    ),
                  ),

                  Text('ePraga',
                    style: TextStyle(
                      fontFamily: 'SystemAnalysis',
                      color: Theme.of(context).primaryColor,
                      fontSize: fonteTitulo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),


                  // ----- # Campos para preenchimento # ----- //
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
                          // Envia para a validação
                          this._validateLogin(ctx);
                        },
                      ),
                    ),
                  ),
                  // ----- # Campos para preenchimento # ----- //


                ],
              ),
            ),
          );
        },
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _MainPage extends State<MainPage> { ... }