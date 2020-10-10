import 'dart:convert';
import 'dart:typed_data';

import 'package:epraga/allFiles.dart';
import 'package:map_launcher/map_launcher.dart';

// ignore: must_be_immutable
class SubsidiaryPage extends StatefulWidget {
  Subsidiary subsidiary;

  SubsidiaryPage(this.subsidiary);

  @override
  _SubsidiaryPage createState() => _SubsidiaryPage();
} // class SubsidiaryPage extends StatefulWidget { ... }

class _SubsidiaryPage extends State<SubsidiaryPage> {
  openMapsSheet(BuildContext context) async {
    try {
      if(widget.subsidiary.latitude == null || widget.subsidiary.longitude == null) {
        Message(context).error('Localização não definida para esta filial! Verifique.');
      }
      else {
        try {
          final coords = Coords(widget.subsidiary.latitude, widget.subsidiary.longitude);
          final title = widget.subsidiary.name;
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
          print(e);
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
    
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
          opacity: 1.0,
          size: 20.0,
        ),
        centerTitle: true,
        title: Text(
          widget.subsidiary.company,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Builder(
        builder: (context){
          return Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              bottom: 5.0,
              left: 15.0,
              right: 15.0,
            ),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        child: CardImage(
                          title: Text(
                            'Localização\n',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontFamily: 'Roboto',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                widget.subsidiary.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                  fontSize: 18.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),

                              Text(
                                widget.subsidiary.address,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Roboto',
                                  fontSize: 14.0,
                                ),
                              ),

                              Text(
                                (widget.subsidiary.latitude == null || widget.subsidiary.longitude == null || widget.subsidiary.latitude.toString().isEmpty || widget.subsidiary.longitude.toString().isEmpty) ? 'Nenhuma localização definida!\nVerifique o cadastro.' : 'Lat/Long: ' + widget.subsidiary.latitude.toString() + ', ' + widget.subsidiary.longitude.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Roboto',
                                  fontSize: 14.0,
                                ),
                              ),

                              RaisedButton(
                                child: Text(
                                  'Abrir no mapa',
                                  style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                    fontSize: 15.0,
                                  ),
                                ),
                                color: Theme.of(context).primaryColor,
                                onPressed: (){
                                  openMapsSheet(context);
                                },
                              ),                         
                            ],
                          ),
                          image: 'assets/animation/maps.flr',
                          animation: 'anim',
                          background: Theme.of(context).backgroundColor,
                        ),
                      ),

                      Card(
                        elevation: 3.0,
                        child: ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.mapSigns,
                                color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                'Croqui',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              FaIcon(
                                FontAwesomeIcons.mapSigns,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                          subtitle: Text(
                            'Clique para abrir a área de atuação',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          children: [
                            Builder(
                              builder: (context){
                                if(widget.subsidiary.croqui == null || widget.subsidiary.croqui.trim().isEmpty) {
                                  return Container(
                                    width: double.infinity,
                                    child: CardImage(
                                      title: Text(
                                        'Nenhum mapeamento atribuído! Verifique o cadastro',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Um mapeamento do local deverá ser gerado! Verifique.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto',
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                      image: 'assets/animation/maps.flr',
                                      animation: 'anim',
                                      background: Theme.of(context).backgroundColor,
                                    ),
                                  );
                                }
                                else {
                                  Uint8List _bytesImage = Base64Decoder().convert(widget.subsidiary.croqui);
                                  return Image.memory(_bytesImage);
                                }
                              },
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ),
          );
        },
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _SubsidiaryPage extends State<SubsidiaryPage> { ... }