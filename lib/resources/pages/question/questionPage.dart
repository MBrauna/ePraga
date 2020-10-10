import 'package:epraga/allFiles.dart';

// ignore: must_be_immutable
class QuestionPage extends StatefulWidget {
  ItemSchudule schuduleItem;
  QuestionPage(this.schuduleItem);

  @override
  _QuestionPage createState() => _QuestionPage();
} // class QuestionPage extends StatefulBuilder { ... }

class _QuestionPage extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          widget.schuduleItem.description,
          softWrap: true,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
          left: 15.0,
          right: 15.0,
        ),
        child: Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ------------------------------------------------------------------- //
              // Se for a primeira visita
              Builder(
                builder: (context){
                  if(widget.schuduleItem.visit) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      child: Card(
                        color: Theme.of(context).backgroundColor,
                        elevation: 3.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width,
                              height: 50.0,
                              color: Theme.of(context).primaryColorDark,
                              alignment: Alignment.center,
                              child: Text(
                                'Primeira visita!\nInforme os produtos que serão utilizados.',
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).backgroundColor,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),

                            SizedBox(
                              width: size.width,
                              child: DataTable(
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      'Produto',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Quantidade',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  )
                                ],
                                rows: Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.listVisit.map((e){
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Container(
                                          width: size.width/2.5,
                                          child: Text(
                                            e.description + ' (' + (e.counter.round().toString() ?? '0' ) + ' ' + (e.measure ?? 'und' ) + ' )',
                                            softWrap: true,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Container(
                                          width: size.width/3,
                                          child: Slider(
                                            value: e.counter,
                                            min: 0,
                                            max: 50,
                                            divisions: 50,
                                            label: e.counter.round().toString(),
                                            onChanged: (value) => setState((){
                                              e.counter=  value;
                                            }),
                                          ),
                                        ),
                                      ),
                                    ]
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  else {
                    return Column(
                      children: [

                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 20.0,
                          ),
                          child: Card(
                            color: Theme.of(context).backgroundColor,
                            elevation: 3.0,
                            child: Container(
                              alignment: Alignment.center,
                              width: size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Container(
                                    width: size.width,
                                    height: 50.0,
                                    color: Theme.of(context).primaryColorDark,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Situação da Isca',
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).backgroundColor,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),


                                  SizedBox(
                                    width: size.width,
                                    child: DataTable(
                                      columns: [
                                        DataColumn(
                                          label: Text(
                                            'Opções disponíveis',
                                            style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ),
                                      ],
                                      rows: Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.listIsca.map((e){
                                        return DataRow(
                                          cells: [
                                            DataCell(
                                              Text(e['description']),
                                            ),
                                          ],
                                          selected: Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.sitIsca.contains(e['id']),
                                          onSelectChanged: (bool value) {
                                            setState(() {
                                              if(value) {
                                                if(!Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.sitIsca.contains(e['id'])) {
                                                  setState((){
                                                    Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.sitIsca.add(e['id']);
                                                  });
                                                } // if(!Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.sitIsca.contains(value)) { ... }
                                              }
                                              else {
                                                if(Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.sitIsca.contains(e['id'])) {
                                                  setState((){
                                                    Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.sitIsca.remove(e['id']);
                                                  });
                                                } // if(!Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.sitIsca.contains(value)) { ... }
                                              }

                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),



                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 20.0,
                          ),
                          child: Card(
                            color: Theme.of(context).backgroundColor,
                            elevation: 3.0,
                            child: Container(
                              alignment: Alignment.center,
                              width: size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Container(
                                    width: size.width,
                                    height: 50.0,
                                    color: Theme.of(context).primaryColorDark,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'A isca foi subsituida?',
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).backgroundColor,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),


                                  SizedBox(
                                    width: size.width,
                                    child: DataTable(
                                      columns: [
                                        DataColumn(
                                          label: Text(
                                            'Opções disponíveis',
                                            style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ),
                                    ],
                                      rows: [
                                        DataRow(
                                          cells:[
                                            DataCell(
                                              RadioListTile(
                                                value: 1,
                                                title: Text('Sim - Isca substituida'),
                                                groupValue: Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.iscaSubstituida,
                                                onChanged: (value){
                                                  setState((){
                                                    Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.iscaSubstituida  = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        DataRow(
                                          cells:[
                                            DataCell(
                                              RadioListTile(
                                                value: 0,
                                                title: Text('Não - Isca permanece'),
                                                groupValue: Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.iscaSubstituida,
                                                onChanged: (value){
                                                  setState((){
                                                    Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.iscaSubstituida  = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),


                      ],
                    );
                  }
                },
              ),
              // ------------------------------------------------------------------- //


              Padding(
                padding: EdgeInsets.only(
                  bottom: 20.0,
                ),
                child: Card(
                  color: Theme.of(context).backgroundColor,
                  elevation: 3.0,
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          width: size.width,
                          height: 50.0,
                          color: Theme.of(context).primaryColorDark,
                          alignment: Alignment.center,
                          child: Text(
                            'O ambiente está adequado?',
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).backgroundColor,
                              fontSize: 15.0,
                            ),
                          ),
                        ),


                        SizedBox(
                          width: size.width,
                          child: DataTable(
                            columns: [
                              DataColumn(
                                label: Text(
                                  'Opções disponíveis',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ),
                          ],
                            rows: [
                              DataRow(
                                cells:[
                                  DataCell(
                                    RadioListTile(
                                      value: 1,
                                      title: Text('Sim - Ambiente adequado'),
                                      groupValue: Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.ambienteAdequado,
                                      onChanged: (value){
                                        setState((){
                                          Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.ambienteAdequado  = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells:[
                                  DataCell(
                                    RadioListTile(
                                      value: 0,
                                      title: Text('Não - Inconformidade'),
                                      groupValue: Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.ambienteAdequado,
                                      onChanged: (value){
                                        setState((){
                                          Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.ambienteAdequado  = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),

              Builder(
                builder: (context){

                  if(Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.ambienteAdequado == 0) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      child: Card(
                        color: Theme.of(context).backgroundColor,
                        elevation: 3.0,
                        child: Container(
                          alignment: Alignment.center,
                          width: size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Container(
                                width: size.width,
                                height: 50.0,
                                color: Theme.of(context).primaryColorDark,
                                alignment: Alignment.center,
                                child: Text(
                                  'Qual não conformidade?',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).backgroundColor,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),


                              SizedBox(
                                width: size.width,
                                child: DataTable(
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        'Opções disponíveis',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ),
                                  ],
                                  rows: Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.listConform.map((e){
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Text(e['description']),
                                        ),
                                      ],
                                      selected: Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.naoConform.contains(e['id']),
                                      onSelectChanged: (bool value) {
                                        setState(() {
                                          if(value) {
                                            if(!Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.naoConform.contains(e['id'])) {
                                              setState((){
                                                Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.naoConform.add(e['id']);
                                              });
                                            } // if(!Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.naoConform.contains(value)) { ... }
                                          }
                                          else {
                                            if(Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.naoConform.contains(e['id'])) {
                                              setState((){
                                                Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.naoConform.remove(e['id']);
                                              });
                                            } // if(!Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.naoConform.contains(value)) { ... }
                                          }

                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } // if(Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listQuestions.ambienteAdequado == 1) { ... }
                  else {
                    return Container();
                  }

                },
              ),


            ],
          ),
        ),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _QuestionPage extends State<QuestionPage> { ... }