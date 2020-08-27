import 'package:epraga/allFiles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:intl/intl.dart';

class SchuduleHeaderPage extends StatefulWidget {
  @override
  _SchuduleHeader createState() => _SchuduleHeader();
}

class _SchuduleHeader extends State<SchuduleHeaderPage> {
  openMapsSheet(BuildContext context, Schudule e) async {
    try {
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: Coords(e.latitude, e.longitude),
                          title: e.description,
                          description: 'Agendamento #' + e.id.toString(),
                        ),
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size    size          = MediaQuery.of(context).size;
    double  fonteTitulo   = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 20) : (size.width / 10));
    double widthButton =  ((size.width - 60.0)/3);

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
                    onPressed: () async {
                      try {
                        await SchuduleController.getGuide(context);
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
                    '${context.watch<App>().schudule.length} disponíveis para ' + DateFormat('dd/MM/yyyy').format(DateTime.now()),
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
                        await SchuduleController.getGuide(context);
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
                  children: context.watch<App>().schudule.map((e) => 
                    
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
                                        onPressed: () => openMapsSheet(context,e),
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
                                          Navigator.push(context, FadePageRoute(SchuduleItemPage(title: e.description,)));
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
                                          Message(context).info('Gráficos indisponíveis para este agendamento! Verifique.');
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
                )
              ],
            );
          }
        },
      ),
    );
  }
}