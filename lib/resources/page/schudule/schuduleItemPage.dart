import 'package:epraga/allFiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SchuduleItemPage extends StatefulWidget {
  Schudule schudule;

  SchuduleItemPage(this.schudule);

  @override
  _SchuduleItemPage createState() => _SchuduleItemPage();
} // class SchuduleItemPage extends StatefulWidget { ... }

class _SchuduleItemPage extends State<SchuduleItemPage> {


  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size    size          = MediaQuery.of(context).size;
    double  fonteTitulo   = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 40) : (size.width / 20));
    double  subfonteTitulo= ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 50) : (size.width / 25));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.schudule.description),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 15.0,
          right: 15.0,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: context.watch<App>().listSchuduleItem.where((element) => element.idSchudule == widget.schudule.id).map((e){
              
              return Card(
                elevation: 10.0,
                child: Container(
                  width: double.infinity,
                  child: Builder(
                    builder: (context){

                      if(e.visit) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text('Visita para coleta de dados',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Roboto',
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(e.latitude == null ? 'Nenhum local marcado' : 'Localização ' + e.latitude.toString() + 'W ' + e.longitude.toString() + 'L',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Roboto',
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),


                            Text(e.description,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Roboto',
                                fontSize: fonteTitulo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                              child: RaisedButton(
                                child: Text(
                                  'Registrar aplicação no local atual',
                                  style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                ),
                                color: Theme.of(context).primaryColor,
                                onPressed: (){},
                              ),
                              width: double.infinity,
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

                            SizedBox(
                              child: RaisedButton(
                                child: Text(
                                  'Salvar alterações',
                                  style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                ),
                                color: Theme.of(context).accentColor,
                                onPressed: (){},
                              ),
                              width: double.infinity,
                            ),

                          ]
                        );
                      } // if(e.visit) { ... }
                      else if(e.combat){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text('Visita para coleta de dados',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Roboto',
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(e.latitude == null ? 'Nenhum local marcado' : 'Localização ' + e.latitude.toString() + 'W ' + e.longitude.toString() + 'L',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Roboto',
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(e.description,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Roboto',
                                fontSize: fonteTitulo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                              child: RaisedButton(
                                child: Text(
                                  e.accept ? 'Finalizar aplicação' : 'Iniciar registro de aplicação',
                                  style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                ),
                                color: Theme.of(context).primaryColor,
                                onPressed: (){
                                  e.accept = !e.accept;
                                },
                              ),
                              width: double.infinity,
                            ),

                            FutureBuilder<void>(
                              future: null,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  // If the Future is complete, display the preview.
                                  return Text('Camera ativa');
                                } else {
                                  return Column(
                                    children: [
                                      Text('Nenhuma foto disponível'),
                                      SizedBox(
                                        width: double.infinity,
                                        child: RaisedButton(
                                          onPressed: (){
                                            Message(context).error('Não foi possível inicializar a câmera! Verifique.');
                                          },
                                          child: Text('Tirar foto',style: TextStyle(color: Theme.of(context).backgroundColor),),
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
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

                            SizedBox(
                              child: RaisedButton(
                                child: Text(
                                  'Salvar alterações',
                                  style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                ),
                                color: Theme.of(context).accentColor,
                                onPressed: (){
                                  Message(context).info('Salvo! Aguardando rede para envio.');

                                },
                              ),
                              width: double.infinity,
                            ),

                          ]
                        );
                      } // if(e.combat){ ... }
                      else {
                        return Text('Configurações incorretas para #' + e.id.toString() + ' ' + e.description,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: 'Roboto',
                            fontSize: subfonteTitulo,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }

                    }
                  ),
                ),
              );

            }).toList(),
          ),
        ),
      )
    );
  } // Widget build(BuildContext context) { ... }
} // class _SchuduleItemPage extends State<SchuduleItemPage> { ... }