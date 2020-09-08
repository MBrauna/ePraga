import 'dart:convert';
import 'dart:typed_data';

import 'package:epraga/allFiles.dart';

// ignore: must_be_immutable
class SchuduleItemPage extends StatefulWidget {
  Schudule data;

  SchuduleItemPage(this.data);

  @override
  _SchuduleItemPage createState() => _SchuduleItemPage();
} // class SchuduleItemPage extends StatefulWidget { ... }

class _SchuduleItemPage extends State<SchuduleItemPage> {
  @override
  Widget build(BuildContext context) {
    Size    size                = MediaQuery.of(context).size;
    double  fonteTitulo         = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 40) : (size.width / 20));

    return Builder(
      builder: (context) => Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
          ),
          child: ListView.builder(
            itemCount: Provider.of<ListData>(context).listSchudule.where((element) => element.id == widget.data.id).first.schuduleItem.length,
            itemBuilder: (context, index) {
              return new Card(
                elevation: 6.0,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Provider.of<ListData>(context).listSchudule.where((element) => element.id == widget.data.id).first.schuduleItem.elementAt(index).description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).backgroundColor,
                            fontSize: fonteTitulo,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        
                        Text(
                          '\n______________',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).backgroundColor,
                            fontSize: 8.0,
                            fontFamily: 'Roboto',
                          ),
                        ),

                        Text(
                          Provider.of<ListData>(context).listSchudule.where((element) => element.id == widget.data.id).first.schuduleItem.elementAt(index).accept ? 'Finalizado' : 'Não iniciado',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).backgroundColor,
                            fontSize: 12.0,
                            fontFamily: 'Roboto',
                          ),
                        ),


                        Text(
                          '______________\n',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).backgroundColor,
                            fontSize: 8.0,
                            fontFamily: 'Roboto',
                          ),
                        ),

                        Builder(
                          builder: (context){

                            if(Provider.of<ListData>(context).listSchudule.where((element) => element.id == widget.data.id).first.schuduleItem.elementAt(index).accept) {
                              return Container(
                                color: Theme.of(context).backgroundColor,
                                width: double.infinity,
                                child: ExpansionTile(
                                  title: Text('Acessar dados enviados'),
                                  children: [
                                    Text(
                                      'Não há perguntas cadastradas',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).errorColor,
                                        fontSize: 12.0,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),

                                    Container(
                                      width: double.infinity,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: Provider.of<ListData>(context).listSchudule.where((element) => element.id == widget.data.id).first.schuduleItem.elementAt(index).images.map((e){
                                            Uint8List _bytesImage = Base64Decoder().convert(e.base64);
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                left: 3.0,
                                                right: 3.0,
                                              ),
                                              child: Image.memory(
                                                _bytesImage,
                                                width: 60.0,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      )
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 15.0,
                                        bottom: 15.0,
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Adicionar nota"
                                        ),
                                        maxLines: 10,
                                        readOnly: true,
                                        controller: TextEditingController(text: Provider.of<ListData>(context, listen: false).listSchudule.where((element) => element.id == widget.data.id).first.schuduleItem.elementAt(index).note),
                                      ),
                                    ),

                                  ],
                                )
                              );
                            }
                            else {
                              return Container(
                                width: double.infinity,
                                color: Theme.of(context).backgroundColor,
                                child: ExpansionTile(
                                  title: Text(
                                    'Iniciar tratamento',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  children: [
                                    Container(
                                      color: Theme.of(context).primaryColor,
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10.0,
                                      ),
                                      child: Text(
                                        'Não há perguntas cadastradas',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).backgroundColor,
                                          fontSize: 12.0,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),


                                    SizedBox(
                                      width: double.infinity,
                                      child: RaisedButton(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            FaIcon(FontAwesomeIcons.cameraRetro),

                                            Text(
                                              'Acessar câmera',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            FaIcon(FontAwesomeIcons.cameraRetro),
                                          ],
                                        ),
                                        textColor: Theme.of(context).backgroundColor,
                                        color: Theme.of(context).primaryColor,
                                        onPressed: (){
                                          Navigator.push(context, FadePageRoute(CameraPage(Provider.of<EPraga>(context,listen: false).cameras, Provider.of<ListData>(context, listen: false).listSchudule.where((element) => element.id == widget.data.id).first.schuduleItem.elementAt(index)))).then((value){
                                            setState(() {});
                                          });
                                        },
                                      ),
                                    ),

                                    Container(
                                      width: double.infinity,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: Provider.of<ListData>(context).listSchudule.where((element) => element.id == widget.data.id).first.schuduleItem.elementAt(index).images.map((e){
                                            Uint8List _bytesImage = Base64Decoder().convert(e.base64);
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                left: 1.5,
                                                right: 1.5,
                                              ),
                                              child: Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  // Conteúdo
                                                  Image.memory(
                                                    _bytesImage,
                                                    width: 60.0,
                                                  ),

                                                  RawMaterialButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        Provider.of<ListData>(context, listen: false).listSchudule.where((element) => element.id == widget.data.id).first.schuduleItem.elementAt(index).images.remove(e);
                                                      });
                                                    },
                                                    constraints: BoxConstraints(),
                                                    elevation: 2.0,
                                                    fillColor: Colors.red,
                                                    child: FaIcon(
                                                      FontAwesomeIcons.trashAlt,
                                                      color: Colors.white,
                                                      size: 20.0,
                                                    ),
                                                    padding: EdgeInsets.all(10.0),
                                                    shape: CircleBorder(),
                                                  ),

                                                ],
                                              )
                                            );
                                          }).toList(),
                                        ),
                                      )
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 15.0,
                                        bottom: 15.0,
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Adicionar nota"
                                        ),
                                        maxLines: 10,
                                        textDirection: TextDirection.ltr,
                                        onChanged: (data){
                                          setState(() {
                                            Provider.of<ListData>(context, listen: false).listSchudule.where((element) => element.id == widget.data.id).first.schuduleItem.elementAt(index).note    = data;
                                          });
                                        },
                                        onSubmitted: (data){
                                          setState(() {
                                            Provider.of<ListData>(context, listen: false).listSchudule.where((element) => element.id == widget.data.id).first.schuduleItem.elementAt(index).note    = data;
                                          });
                                        },
                                        //controller: TextEditingController(text: Provider.of<ListData>(context, listen: false).listSchudule.where((element) => element.id == widget.data.id).first.schuduleItem.elementAt(index).note),
                                      ),
                                    ),

                                    SizedBox(
                                      width: double.infinity,
                                      child: RaisedButton(
                                        child: Text('Finalizar tarefa'),
                                        textColor: Theme.of(context).backgroundColor,
                                        color: Theme.of(context).accentColor,
                                        onPressed: () async {
                                          setState((){
                                            Provider.of<ListData>(context, listen: false).listSchudule.where((element) => element.id == widget.data.id).first.schuduleItem.elementAt(index).accept  = true;
                                            Provider.of<ListData>(context, listen: false).listSchudule.where((element) => element.id == widget.data.id).first.lastAlt = DateTime.now();
                                          });
                                          await DataController.setDatabaseData(context, ['schudule']);
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            }
                          },
                        ),
                        


                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _SchuduleItemPage extends State<SchuduleItemPage> { ... }