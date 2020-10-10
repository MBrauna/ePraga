import 'package:epraga/allFiles.dart';

// ignore: must_be_immutable
class SchuduleItemPage extends StatefulWidget {
  int idSchudule;
  SchuduleItemPage(this.idSchudule);

  @override
  _SchuduleItemPage createState() => _SchuduleItemPage();
} // class SchuduleItemPage extends StatefulWidget { ... }

class _SchuduleItemPage extends State<SchuduleItemPage> {
  
  @override
  Widget build(BuildContext context) {
    Schudule schudule = Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule));
    Size size = MediaQuery.of(context).size;
    double fonteTitulo  = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 40) : (size.width / 20));
    double cardData = (size.width/2.5);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
          opacity: 1,
        ),
        title: Text(
          schudule.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 15.0,
          right:15.0,
        ),
        child: Builder(
          builder: (context){
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Para conectividade ...
                  Connectivity(),

                  // Para apresentação
                  CardImage(
                    image: 'assets/animation/robot.flr',
                    animation: 'reposo',
                    background: Theme.of(context).backgroundColor,
                    title: Text(
                      schudule.listItemSchudule.length.toString() + ' tarefas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: fonteTitulo,
                      ),
                    ),
                    subtitle: Text(
                      'Itens em verde já estão concluídas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 12.0,
                      ),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.mapSigns,
                            color: Theme.of(context).backgroundColor,
                          ),
                          Text(
                            'Dados do local',
                            softWrap: true,
                            style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          FaIcon(
                            FontAwesomeIcons.mapSigns,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ],
                      ),
                      onPressed: (){
                        Navigator.of(context).push(FadePageRoute(SubsidiaryPage(
                          Provider.of<App>(context, listen: false).listSubsidiary.firstWhere((element) => (element.id == schudule.idSubsidiary))
                        ))).then((value){
                          SenderController.senderLocation(context);
                        });
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                  ),

                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.length,
                    itemBuilder: (BuildContext context, int idx) {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        child: Card(
                          color: Theme.of(context).backgroundColor,
                          elevation: 3.0,
                          shape: Border(
                            left: BorderSide(
                              color: Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(idx).accept ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
                              width: 20.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                              right: 5.0,
                              left: 25.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
                                Text(
                                  Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(idx).description,
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  'Área/Spot: ' + Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(idx).spot.toString().padLeft(4,'0'),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  'Foto(s): ' + Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(idx).listImages.length.toString() + ' de ' + Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(idx).qtdeImages.toString() + ' solicitadas',
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: cardData,
                                      child: RaisedButton(
                                        color: Theme.of(context).primaryColor,
                                        child: FaIcon(
                                          FontAwesomeIcons.solidImage,
                                          color: Theme.of(context).backgroundColor,
                                        ),
                                        onPressed: (){
                                          Navigator.of(context).push(FadePageRoute(ImagePage(Provider.of<App>(context, listen: false).cameraList,Provider.of<App>(context,listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(idx)))).then((value){
                                            SenderController.senderLocation(context);
                                            setState((){});
                                          });
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      width: cardData,
                                      child: RaisedButton(
                                        color: Theme.of(context).primaryColor,
                                        child: FaIcon(
                                          FontAwesomeIcons.question,
                                          color: Theme.of(context).backgroundColor,
                                        ),
                                        onPressed: (){
                                          Navigator.of(context).push(FadePageRoute(QuestionPage(Provider.of<App>(context,listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(idx)))).then((value){
                                            SenderController.senderLocation(context);
                                            setState((){});
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
                                
                                SizedBox(
                                  width: size.width,
                                  child: RaisedButton(
                                    color: Theme.of(context).accentColor,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.checkDouble,
                                          color: Theme.of(context).backgroundColor,
                                        ),
                                        Text(
                                          'Finalizar',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).backgroundColor,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        FaIcon(
                                          FontAwesomeIcons.checkDouble,
                                          color: Theme.of(context).backgroundColor,
                                        ),
                                      ],
                                    ),
                                    onPressed: (){
                                      if(Provider.of<App>(context,listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(idx).accept){
                                        Message(context).info('Conteúdo marcado para envio! Aguarde.');
                                      }
                                      else {
                                        if(QuestionController.validateQuestion(context, Provider.of<App>(context,listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(idx))) {
                                          if(Provider.of<App>(context,listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(idx).listImages.length < Provider.of<App>(context,listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(idx).qtdeImages) {
                                            Message(context).error('Quantidade de imagens não atingiu a quantia ideal! Verifique.');
                                          }
                                          else {
                                            setState((){
                                              Provider.of<App>(context,listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(idx).accept  = true;
                                            });

                                            DataController.setData(context, ['schudule']).then((value){
                                              SenderController.senderLocation(context);
                                              SenderController.senderSchudule(context,Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(idx));
                                              SenderController.senderQuestions(context,Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(idx));
                                            });

                                          }
                                        }
                                        else {
                                          Message(context).error('Perguntas não foram respondidas! Verifique.');
                                        }
                                      }

                                    },
                                  ),
                                ),
                              
                              ],
                            ),
                          ),
                        ),
                      );
                    }
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