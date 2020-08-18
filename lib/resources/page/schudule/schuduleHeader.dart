import 'package:epraga/allFiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchuduleHeader extends StatefulWidget {
  @override
  _SchuduleHeader createState() => _SchuduleHeader();
}

class _SchuduleHeader extends State<SchuduleHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('GuidePage'),
      /*padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 50.0,
      ),*/
      child: Builder(
        builder: (context) {
          if(context.watch<App>().schudule.length <= 0) {

            // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # //
            // Para lista vazia

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: (){
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
          else {
            // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # //
            // Para lista preenchida

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {},
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
                  background: Theme.of(context).accentColor,
                  title: Text(
                    'Agendamento',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(
                    '\n\n\nAbaixo todos os agendamentos disponíveis.',
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
                  children: context.watch<App>().schudule.map((e) => 
                    
                    Text('123'),
                    
                  ).toList(),
                )
              ],
            );
          }
        },
      ),
    );
  }
}