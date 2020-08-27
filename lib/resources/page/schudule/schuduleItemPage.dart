import 'package:epraga/app/util/message.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SchuduleItemPage extends StatefulWidget {
  String title;
  
  SchuduleItemPage({this.title});

  @override
  _SchuduleItemPage createState() => _SchuduleItemPage();
} // class SchuduleItemPage extends StatefulWidget { ... }

class _SchuduleItemPage extends State<SchuduleItemPage> {

  @override
  Widget build(BuildContext context) {
    String eText = 'Iniciar Tarefa';
    Color eColor = Theme.of(context).accentColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (context){

          return Center(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: Card(
                    color: Colors.red[900],
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50.0,
                          child: Text(
                            'Atenção, você está a 936,12km do local de atuação\n\nVerifique sua localização.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            color: eColor,
                            child: Text(
                              eText,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: (){
                              Message(context).error('Você está longe da área de atuação! Verifique.',tempo: 2);
                            },
                          ),
                        ),



                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Entrada Norte [Equipamento NGV85101S]',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: (){
                              Message(context).error('Você está longe da área de atuação! Verifique.',tempo: 2);
                            },
                          ),
                        ),



                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Silo secador de grão [Equipamento UJH75A96]',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: (){
                              Message(context).error('Você está longe da área de atuação! Verifique.',tempo: 2);
                            },
                          ),
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Celeiro - Direita [Equipamento GHA75AD8]',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: (){
                              Message(context).error('Você está longe da área de atuação! Verifique.',tempo: 2);
                            },
                          ),
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Celeiro - Central [Equipamento G7ASH7901]',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: (){
                              Message(context).error('Você está longe da área de atuação! Verifique.',tempo: 2);
                            },
                          ),
                        )


                      ],
                    ),
                  ),
                )
              ],
            )

          );

        },
      )
    );
  } // Widget build(BuildContext context) { ... }
} // class _SchuduleItemPage extends State<SchuduleItemPage> { ... }