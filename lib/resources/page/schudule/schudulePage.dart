import 'package:flutter/material.dart';
import 'package:epraga/allFiles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SchudulePage extends StatefulWidget {
  @override
  _SchudulePage createState() => _SchudulePage();
} // class SchudulePage extends StatefulWidget { ... }

class _SchudulePage extends State<SchudulePage> {
  @override
  Widget build(BuildContext context) {
    Size    size        = MediaQuery.of(context).size;
    double  fonteTitulo = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 20) : (size.width / 10));
    //double  widthButton = ((size.width - 60.0)/3);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      key: Key('SchudulePage'),
      child: Builder(
        builder: (ctx) {
          // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
          if(context.read<App>().listSchudule.length <= 0) {
            return Column(
              children: [

                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () async {
                      try {
                        await SchuduleController.requestSchudule(context);
                        Navigator.pushReplacement(context, FadePageRoute(MainPage()));
                      } // try { ... }
                      catch(erro){
                        Message(context).error('Não foi possível atualizar! Falha no sistema.');
                      } // catch(erro){ ... }
                    },
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Atualizar agendamento',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),


                CardImage(
                  image: 'assets/flare/Mouse.flr',
                  animation: 'walking (w/ hood)',
                  background: Theme.of(context).errorColor,
                  title: Text(
                    'Nenhum agendamento disponível!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(
                    '\n\n\nNão há agendas disponíveis\n\nTente atualizar a lista ou solicite ao administrador do sistema.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                ),


              ],
            );
          } // if(context.watch<App>().listSchudule.length <= 0) { ... }
          // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
          else {

            return Column(
              children: [

                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () async {
                      try {
                        await SchuduleController.requestSchudule(context);
                        //Navigator.pushReplacement(context, FadePageRoute(MainPage()));
                      } // try { ... }
                      catch(erro){
                        Message(context).error('Não foi possível atualizar! Falha no sistema.');
                      } // catch(erro){ ... }
                    },
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Atualizar agendamento',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),



                CardImage(
                  image: 'assets/flare/Mouse.flr',
                  animation: 'wrong',
                  background: Theme.of(context).primaryColor,
                  title: Text(
                    'EPraga',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SystemAnalysis',
                      color: Theme.of(context).backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: fonteTitulo,
                    ),
                  ),
                  subtitle: Text(
                    '${context.read<App>().listSchudule.length} itens disponíveis\npara atendimento em ' + DateFormat('dd/MM/yyyy').format(DateTime.now()),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),



                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: context.read<App>().listSchudule.map((e) => 
                    Card(
                      color: Theme.of(context).cardColor,
                      elevation: 5.0,
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            Text(
                              e.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              ),
                            ),




                            Text(
                              '_________',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                fontSize: 9.0,
                              ),
                            ),

                            


                            Text(
                              ' tarefas disponíveis',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),


                            Text(
                              '_________',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                fontSize: 9.0,
                              ),
                            ),


                            Text(
                              '\n\nAgendamento previsto para ' + DateFormat('dd/MM/yyyy').format(e.startDate),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.italic,
                                fontSize: 12.0,
                              ),
                            ),

                            SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                color: Theme.of(context).accentColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.mapMarked,
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                    Text(
                                      'Dados do local',
                                      style: TextStyle(
                                        color: Theme.of(context).backgroundColor,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.mapMarked,
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                  ],
                                ),
                                onPressed: (){
                                  // Abre um popup com informações
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              SubsidiaryPage(e),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          RaisedButton(
                                            color: Theme.of(context).accentColor,
                                            child: Text('fechar'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),


                            SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                color: Theme.of(context).accentColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.play,
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                    Text(
                                      'Iniciar tratamento',
                                      style: TextStyle(
                                        color: Theme.of(context).backgroundColor,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.play,
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                  ],
                                ),
                                onPressed: (){
                                  Navigator.push(context, FadePageRoute(SchuduleItemPage(e)));
                                },
                              ),
                            ),






                          ],
                        ),
                      ),
                    ),

                  ).toList(),
                ),


              ],
            );

          } // else { ... }
          // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

        },
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _SchudulePage extends State<SchudulePage> { ... }