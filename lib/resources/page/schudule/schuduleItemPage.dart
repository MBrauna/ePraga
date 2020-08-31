import 'package:epraga/allFiles.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class SchuduleItemPage extends StatefulWidget {
  Schudule schudule;
  
  SchuduleItemPage({this.schudule});

  @override
  _SchuduleItemPage createState() => _SchuduleItemPage();
} // class SchuduleItemPage extends StatefulWidget { ... }

class _SchuduleItemPage extends State<SchuduleItemPage> {
  openMapsSheet(BuildContext context, num latitude, num longitude, String description, int id) async {
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
                          coords: Coords(latitude, longitude),
                          title: description,
                          description: 'Agendamento #' + id.toString(),
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
  Widget build(BuildContext context) {
    Size    size          = MediaQuery.of(context).size;
    double  fonteTitulo   = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 20) : (size.width / 10));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          widget.schudule.description,
        ),
      ),
      body: SingleChildScrollView(
        child: Builder(
          builder: (context){

            return Center(
              child: Column(
                children: [
                  Connectivity(),

                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Column(
                      children: context.watch<App>().schudule.where((element) => element.id == widget.schudule.id).first.listSchuduleItem.map((e){
                        return Card(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('ePraga',
                                  style: TextStyle(
                                    fontFamily: 'SystemAnalysis',
                                    color: Theme.of(context).primaryColor,
                                    fontSize: fonteTitulo,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  e.description,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),

                                Text(
                                  e.quantityImages.toString() + ' imagens necessárias',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),

                                Text(
                                  'Iniciado em ' + DateFormat('dd/MM/yyyy').format(e.startDate ?? DateTime.now()),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),

                                Visibility(
                                  maintainSize: true, 
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: (context.watch<App>().schudule.where((element) => element.id == widget.schudule.id).first.listSchuduleItem.where((element) => element.id == e.id).first.startDate == null), 
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: RaisedButton(
                                      color: Theme.of(context).accentColor,
                                      child: Text(
                                        'Iniciar tarefa #${e.id}',
                                        style: TextStyle(
                                          color: Theme.of(context).backgroundColor,
                                        ),
                                      ),
                                      onPressed: (){
                                        context.read<App>().schudule.where((element) => element.id == widget.schudule.id).first.listSchuduleItem.where((element) => element.id == e.id).first.startDate = DateTime.now();
                                        DataController.setDatabaseData(context, ['schudule']);
                                        Navigator.pushReplacement(context, FadePageRoute(SchuduleItemPage(schudule: context.read<App>().schudule.where((element) => element.id == widget.schudule.id).first,)));
                                      },
                                    ),
                                  )
                                ),

                                Visibility(
                                  maintainSize: true, 
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: (context.watch<App>().schudule.where((element) => element.id == widget.schudule.id).first.listSchuduleItem.where((element) => element.id == e.id).first.startDate != null), 
                                  child: Builder(builder: (ctx){

                                    if(context.read<App>().schudule.where((element) => element.id == widget.schudule.id).first.listSchuduleItem.where((element) => element.id == e.id).first.latitude == null) {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          SizedBox(
                                            width: double.infinity,
                                            child: RaisedButton(
                                              onPressed: (){},
                                              color: Theme.of(context).accentColor,
                                              child: Text(
                                                'Marcar localização',
                                                style: TextStyle(
                                                  color: Theme.of(context).backgroundColor
                                                ),
                                              ),
                                            ),
                                          ),


                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 15.0,
                                            ),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Adicionar nota"
                                              ),
                                              maxLines: 10,
                                            ),
                                          ),

                                        ],
                                      );
                                    }
                                    else {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          SizedBox(
                                            width: double.infinity,
                                            child: RaisedButton(
                                              onPressed: (){},
                                              color: Theme.of(context).accentColor,
                                              child: Text(
                                                'Fotografar',
                                                style: TextStyle(
                                                  color: Theme.of(context).backgroundColor
                                                ),
                                              ),
                                            ),
                                          ),


                                          SizedBox(
                                            width: double.infinity,
                                            child: RaisedButton(
                                              color: Theme.of(context).primaryColor,
                                              child: Text(
                                                'Ir até o local',
                                                style: TextStyle(
                                                  color: Theme.of(context).backgroundColor
                                                ),
                                              ),
                                              onPressed: () => openMapsSheet(context,e.latitude, e.longitude, e.description, e.id),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 15.0,
                                            ),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Adicionar nota"
                                              ),
                                              maxLines: 10,
                                            ),
                                          ),

                                        ],
                                      );
                                    }
                                  }),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );

          },
        ),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _SchuduleItemPage extends State<SchuduleItemPage> { ... }