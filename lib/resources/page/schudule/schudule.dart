import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../../../model/allModels.dart' as models;
import './../../../app/controller/SchuduleController.dart';
import './../../../app/util/message.dart';

class Schudule extends StatefulWidget {
  @override
  _Schudule createState() => _Schudule();
} // class Schudule extends StatefulWidget { ... }

class _Schudule extends State<Schudule> {
  bool execAtt = true;
  @override
  void initState() {
    super.initState();

    SchuduleController.getDecision(context).then((value){
      setState(() {
        this.execAtt = true;
      });
    });

    setState(() {
      this.execAtt = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size    size          = MediaQuery.of(context).size;
    double  subfonteTitulo= ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 50) : (size.width / 25));
    double  logoSize      = (MediaQuery.of(context).orientation == Orientation.landscape) ? (size.height / 2) : (size.height / 4);

    return Builder(
      key: Key('Schudule'),
      builder: (context) {

        if(context.watch<models.App>().schudule.length <= 0) {

          return Padding(
            padding: EdgeInsets.only(
              top: 5.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: RaisedButton(
                      child: Text(
                        'Atualizar agendamento',
                        style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        if(this.execAtt) {
                          SchuduleController.getDecision(context).then((value){
                            setState(() {
                              this.execAtt = true;
                            });
                          });

                          setState(() {
                            this.execAtt = false;
                          });
                        }
                      },
                    ),
                  ),
                ),
              
                Container(
                  height: logoSize,
                  child: new FlareActor(
                    'assets/flare/empty_state.flr',
                    animation: 'idle',
                  ),
                ),
                Text('Nenhuma agenda disponível',
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Roboto',
                    fontSize: subfonteTitulo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );

        } // if(context.watch<models.App>().schudule.length <= 0) { ... }
        else {

          return Padding(
            padding: EdgeInsets.only(
              top: 5.0,
            ),
            child: Column(
              children: context.watch<models.App>().schudule.map((e) => 
                
                
                Container(
                  width: double.infinity,
                  //height: 120.0,
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    bottom: 5.0,
                    top: 5.0,
                  ),
                  child: Card(
                    color: Theme.of(context).cardColor,
                    child: ExpansionTile(
                      title: Text(
                        '${e.description}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'Roboto',
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Text(
                        '${e.quantity} tarefas com código #${e.id} de agendamento',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[950],
                          fontFamily: 'Roboto',
                          fontSize: 12.0,
                        ),
                      ),
                      children: e.task.map((t) => 


                        Container(
                          width: double.infinity,
                          //height: 120.0,
                          padding: EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                            bottom: 5.0,
                            top: 5.0,
                          ),
                          child: Card(
                            color: t.execDate == null ? Colors.grey[100] : Colors.green[100],
                            child: ExpansionTile(
                              title: Text(
                                '${t.description}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              subtitle: Text(
                                '${t.quantityImages ?? 0} imagens são esperadas para a tarefa #${t.id.toString()}\nNota: ${t.note}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[950],
                                  fontFamily: 'Roboto',
                                  fontSize: 10.0,
                                ),
                              ),
                              children: [


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    SizedBox(
                                      width: (size.width/2) - (size.width/9),
                                      child: RaisedButton(
                                        onPressed: (){
                                          Message(context).info('A tarefa #${t.id} foi marcada como iniciada!\nLog será coletado até sua finalização.');
                                        },
                                        child: Text(
                                          'Iniciar tarefa',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: (size.width/2) - (size.width/9),
                                      child: RaisedButton(
                                        onPressed: (){
                                          Message(context).info('A tarefa #${t.id} foi marcada como finalizada!');
                                        },
                                        child: Text(
                                          'Finalizar tarefa',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        color: Theme.of(context).errorColor,
                                      ),
                                    ),
                                  ],
                                ),


                                SizedBox(
                                  width: size.width,
                                  child: RaisedButton(
                                    onPressed: (){
                                      Message(context).info('A tarefa atual foi marcada como não dependente de imagens!');
                                    },
                                    child: Text(
                                      'Adicionar imagens',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ),


                      ).toList()
                    ),
                  ),
                ),

              ).toList(),
            )
          );
        } // else { ... }
      },
    );
  } // Widget build(BuildContext context) { ... }
}