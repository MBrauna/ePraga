import 'dart:convert';
import 'dart:typed_data';

import 'package:epraga/allFiles.dart';
import 'package:intl/intl.dart';

class SchudulePage extends StatefulWidget {
  @override
  _SchudulePage createState() => _SchudulePage();
} // class MainPage extends StatefulWidget { ... }

class _SchudulePage extends State<SchudulePage> {
  bool execAtt  = false;

  void openSubsidiary(BuildContext context, Schudule data) {
    Subsidiary subsidiary  = Provider.of<ListData>(context, listen: false).listSubsidiary.where((element) => element.id == data.idSubsidiary).first;

    Size    size                    = MediaQuery.of(context).size;
    double  fonteTitulo             = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 16) : (size.width / 8));
    double  subfonteTitulo          = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 50) : (size.width / 25));

    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                

                Text('ePraga',
                  style: TextStyle(
                    fontFamily: 'SystemAnalysis',
                    color: Theme.of(context).primaryColor,
                    fontSize: fonteTitulo,
                    fontWeight: FontWeight.bold,
                  ),
                ),


                Text(
                  'Tec Solution',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Roboto',
                    fontSize: subfonteTitulo,
                    fontWeight: FontWeight.bold,
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(
                    top: 40.0,
                  ),
                ),


                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '#' + subsidiary.id.toString() + ' - ' + subsidiary.name,
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontFamily: 'Roboto',
                        fontSize: subfonteTitulo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      subsidiary.description,
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontFamily: 'Roboto',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    Padding(
                      padding: EdgeInsets.only(
                        top: 40.0,
                      ),
                    ),


                    Text(
                      'Endereço: ' + subsidiary.address,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Roboto',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    Text(
                      subsidiary.latitude == null ? 'Sem coordenadas cadastradas' : 'Coods: ' + subsidiary.latitude.toString() + 'W, ' + subsidiary.longitude.toString() + 'L',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Roboto',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),





              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  void openImage(BuildContext context, Schudule data) {
    Subsidiary subsidiary = Provider.of<ListData>(context, listen: false).listSubsidiary.where((element) => element.id == data.idSubsidiary).first;
    if(subsidiary != null && subsidiary.id != null && subsidiary.croqui != null && subsidiary.croqui.trim().length > 0) {

      Uint8List _bytesImage = Base64Decoder().convert(subsidiary.croqui);
      showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Image.memory(_bytesImage),
                ],
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    else {
      Message(context).error('Nenhum croqui adicionado a este local! Verifique com o administrador do sistema.',tempo: 1);
    } // else { ... }
  }


  openMapsSheet(BuildContext context, Schudule data) async {
    try {
      Subsidiary tmpSubsidiary  = Provider.of<ListData>(context, listen: false).listSubsidiary.where((element) => element.id == data.idSubsidiary).first;

      if(tmpSubsidiary.latitude == null) {
        Message(context).error('Localização não definida para esta filial! Verifique.');
      }
      else {
        try {
          final coords = Coords(tmpSubsidiary.latitude, tmpSubsidiary.longitude);
          final title = data.description;
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
                            onTap: (){ 
                              map.showMarker(
                              coords: coords,
                              title: title,
                              );
                            },
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
          Message(context).error('Erro ao carregar mapa!',tempo: 1);
        }
      }
    }
    catch(erro) {
      print(erro);
      Message(context).error('Não foi possível abrir mapas! Verifique.', tempo: 1);
    }
  }


  @override
  Widget build(BuildContext context) {
    Size    size                = MediaQuery.of(context).size;
    double  fonteTitulo         = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 40) : (size.width / 20));

    List<Schudule> listSchudule = Provider.of<ListData>(context).listSchudule;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        key: Key('SchudulePage'),
        children: [
          // -- PARA VERIFICAR CONEXÃO DE REDE -- //
          Connectivity(),

          // -- OPÇÃO DE ATUALIZAÇÃO DOS DADOS -- //
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color:  Theme.of(context).accentColor,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FaIcon(
                    FontAwesomeIcons.syncAlt,
                    color: Theme.of(context).backgroundColor,
                  ),

                  Text(
                    'Atualizar agendamento',
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),

                  FaIcon(
                    FontAwesomeIcons.syncAlt,
                    color: Theme.of(context).backgroundColor,
                  ),
                ],
              ),
              onPressed: () async {
                if(!execAtt) {
                  setState(() {
                    execAtt = true;
                  });

                  bool verifyConn = await VerifyNetwork().verify();

                  if(verifyConn) {
                    bool requestData  = await RequestController.requestSchudule(context);
                    if(requestData) {
                      Message(context).info('Dados atualizados!',tempo: 1);
                    }
                    else {
                      Message(context).error('Não foi possível atualizar!',tempo: 1);
                    }
                  } // if(verifyConn) { ... }
                  else {
                    await DataController.getDatabaseData(context, ['schudule']);
                  } // else { ... }

                  setState(() {
                    execAtt = false;
                  });
                }
                else {
                  Message(context).info('Aguarde finalizar a atualização atual!',tempo: 1);
                }
              },
            ),
          ),



          // -- APRESENTAÇÃO - ICONE DE TODOS OS DADOS -- //
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
              '${listSchudule.length} ${listSchudule.length <= 1 ? "item disponível" : "itens disponíveis"}\n' + DateFormat('dd/MM/yyyy').format(DateTime.now()),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          
          
          // -- LISTA DE TODOS OS AGENDAMENTOS EXISTENTES -- //
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listSchudule.length,
            itemBuilder: (BuildContext ctx, int idx) {

              return new Padding(
                padding: EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: Card(
                  key: Key('schudule_' + listSchudule.elementAt(idx).id.toString()),
                  elevation: 2.5,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 5.0,
                      right: 5.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Column(
                      verticalDirection: VerticalDirection.down,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ->> # <<- ->> # <<- ->> # <<- ->> # <<- ->> # <<- ->> # <<- ->> # <<- ->> # <<- //
                        Text(
                          listSchudule.elementAt(idx).description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: fonteTitulo,
                            fontFamily: 'Roboto',
                          ),
                        ),

                        Text(
                          '______________',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 8.0,
                            fontFamily: 'Roboto',
                          ),
                        ),

                        Text(
                          'Agendamento para ' + DateFormat('dd/MM/yyyy').format(listSchudule.elementAt(idx).updatedAt),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 12.0,
                            fontFamily: 'Roboto',
                          ),
                        ),

                        Text(
                          (listSchudule.elementAt(idx).status ? 'Aguardando conclusão' : 'Concluído'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: (listSchudule.elementAt(idx).status ? Theme.of(context).errorColor : Theme.of(context).accentColor),
                            fontSize: 12.0,
                            fontFamily: 'Roboto',
                          ),
                        ),

                        Text(
                          '______________\n\n',
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 8.0,
                            fontFamily: 'Roboto',
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            // Botão de empresa
                            MaterialButton(
                              color: Theme.of(context).primaryColor,
                              highlightColor: Theme.of(context).accentColor,
                              focusColor: Theme.of(context).accentColor,
                              hoverColor: Theme.of(context).accentColor,
                              splashColor: Theme.of(context).accentColor,
                              textColor: Colors.white,
                              child: FaIcon(
                                FontAwesomeIcons.city,
                                size: 20.0,
                              ),
                              padding: EdgeInsets.all(10.0),
                              //shape: CircleBorder(),
                              onPressed: () {
                                this.openSubsidiary(context,listSchudule.elementAt(idx));
                              },
                            ),

                            // Botão para dados da agenda
                            MaterialButton(
                              color: Theme.of(context).accentColor,
                              highlightColor: Theme.of(context).primaryColor,
                              focusColor: Theme.of(context).primaryColor,
                              hoverColor: Theme.of(context).primaryColor,
                              splashColor: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: FaIcon(
                                FontAwesomeIcons.eye,
                                size: 20.0,
                              ),
                              padding: EdgeInsets.all(10.0),
                              //shape: CircleBorder(),
                              onPressed: () {
                                Navigator.push(context, FadePageRoute(SchuduleItemPage(listSchudule.elementAt(idx))));
                              },
                            ),

                            // Botão para ir até o local
                            MaterialButton(
                              color: Theme.of(context).primaryColor,
                              highlightColor: Theme.of(context).accentColor,
                              focusColor: Theme.of(context).accentColor,
                              hoverColor: Theme.of(context).accentColor,
                              splashColor: Theme.of(context).accentColor,
                              textColor: Colors.white,
                              child: FaIcon(
                                FontAwesomeIcons.mapMarkedAlt,
                                size: 20.0,
                              ),
                              padding: EdgeInsets.all(10.0),
                              //shape: CircleBorder(),
                              onPressed: () {
                                this.openMapsSheet(context,listSchudule.elementAt(idx));
                              },
                            ),
                          ],
                        ),

                        

                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).backgroundColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FaIcon(FontAwesomeIcons.mapPin),
                                Text(
                                  'Área de instalação',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  )
                                ),
                                FaIcon(FontAwesomeIcons.mapPin),
                              ],
                            ),
                            onPressed: (){
                              this.openImage(context, listSchudule.elementAt(idx) );
                            },
                          )
                        ),

                      ],
                    )
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _SchudulePage extends State<SchudulePage> { ... }