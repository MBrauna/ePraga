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
    double  widthButton = ((size.width - 60.0)/3);

    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Builder(
          builder: (context) {
            // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
            if(context.watch<App>().listSchudule.length <= 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () async {
                        try {
                          await SchuduleController.requestSchudule(context);
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
                  )
                ],
              );
            }

            // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

            else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      '${context.watch<App>().listSchudule.length} itens disponíveis\npara atendimento em ' + DateFormat('dd/MM/yyyy').format(DateTime.now()),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),


                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () async {
                        try {
                          await SchuduleController.requestSchudule(context);
                        }
                        catch(erro){
                          print(erro);
                        }
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



                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: context.watch<App>().listSchudule.map((e) => 
                      Card(
                        color: Theme.of(context).cardColor,
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
                                '1 tarefas disponíveis',
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
                                '---\n${e.description}\n---\n',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12.0,
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

                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: widthButton,
                                      child: Ink(
                                        decoration: const ShapeDecoration(
                                          color: Color(0xff002b70),
                                          shape: StadiumBorder(),
                                        ),
                                        child: IconButton(
                                          icon: FaIcon(FontAwesomeIcons.mapMarked),
                                          color: Theme.of(context).backgroundColor,
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      width: widthButton,
                                      child: Ink(
                                        decoration: const ShapeDecoration(
                                          color: Color(0xff077000),
                                          shape: StadiumBorder(),
                                        ),
                                        child: IconButton(
                                          icon: FaIcon(FontAwesomeIcons.playCircle),
                                          color: Theme.of(context).backgroundColor,
                                          onPressed: () {
                                            
                                          },
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      width: widthButton,
                                      child: Ink(
                                        decoration: const ShapeDecoration(
                                          color: Color(0xff002b70),
                                          shape: StadiumBorder(),
                                        ),
                                        child: IconButton(
                                          icon: FaIcon(FontAwesomeIcons.chartPie),
                                          color: Theme.of(context).backgroundColor,
                                          onPressed: () {
                                            Message(context).info('Gráficos indisponíveis para este agendamento! Verifique.',tempo: 2);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
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
            }
            // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //







          },
        ),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _SchudulePage extends State<SchudulePage> { ... }