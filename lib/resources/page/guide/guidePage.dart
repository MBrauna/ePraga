import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:epraga/allFiles.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePage createState() => _GuidePage();
} // class GuidePage extends StatefulWidget { ... }

class _GuidePage extends State<GuidePage> {
  @override
  Widget build(BuildContext context) {
    List normalizeText  = ['manual disponível para leitura','manuais disponíveis para leitura'];
    bool activeField    = true;
    String hash         = context.watch<App>().login.hash;

    return Container(
      key: Key('GuidePage'),
      /*padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 50.0,
      ),*/
      child: Builder(
        builder: (context) {
          if(context.watch<App>().guide.length <= 0) {

            // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # //
            // Para lista vazia

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () async {
                      if(activeField) {
                        setState(() {
                          activeField = false;
                        });

                        bool refresh  = await GuideController.getGuide(context,hash: hash);

                        if(refresh) {
                          Message(context).info('Guias atualizados!',tempo: 2);
                        } // if(value) { ... }
                        else {
                          Message(context).error('Não foi possível atualizar os guias! Verifique.',tempo: 3);
                        } // else { ... }

                        setState(() {
                          activeField = true;
                        });
                      }
                    },
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Atualizar manuais',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),


                CardImage(
                  image: 'assets/flare/empty_state.flr',
                  animation: 'idle',
                  background: Colors.deepOrangeAccent,
                  title: Text(
                    'Nenhum manual encontrado!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(
                    '\n\n\nOhhh não!\nNenhum manual está disponível para leitura neste momento, tente novamente mais tarde.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                )
              ],
            );

          }
          else {
            // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # //
            // Para lista preenchida

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () async {
                      if(activeField) {
                        setState(() {
                          activeField = false;
                        });

                        bool refresh  = await GuideController.getGuide(context,hash: hash);
                        if(refresh) {
                          Message(context).info('Guias atualizados!',tempo: 2);
                        } // if(value) { ... }
                        else {
                          Message(context).error('Não foi possível atualizar os guias! Verifique.',tempo: 3);
                        } // else { ... }

                        setState(() {
                          activeField = true;
                        });
                      }
                    },
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Atualizar manuais',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),

                CardImage(
                  image: 'assets/flare/robot.flr',
                  animation: 'reposo',
                  title: Text(
                    'Guias e manuais de intruções',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(
                    '${context.watch<App>().guide.length} ${context.watch<App>().guide.length > 0 ? normalizeText[1]: normalizeText[0]}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),


                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: context.watch<App>().guide.map((e) => 
                  
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        top: 2.5,
                        bottom: 2.5,
                      ),
                      child: Card(
                        color: Theme.of(context).dialogBackgroundColor,
                        child: ExpansionTile(
                          title: Text(e.title),
                          children: [
                            Container(
                              width: double.infinity,
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                ' --- ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                ),
                              ),
                            ),

                            Text(
                              e.body,
                              style: TextStyle(
                                fontFamily: 'Roboto'
                              ),
                            ),

                            Container(
                              width: double.infinity,
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                ' --- ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                  ).toList(),
                )
              ],
            );
          }
        },
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _GuidePage extends State<GuidePage> { .. }