import 'package:epraga/allFiles.dart';

// ignore: must_be_immutable
class SchuduleElement extends StatefulWidget {
  Schudule schudule;

  SchuduleElement(this.schudule);

  @override
  _SchuduleElement createState()  =>  _SchuduleElement();
}

class _SchuduleElement extends State<SchuduleElement> {
  @override
  Widget build(BuildContext context) {

    Size size         = MediaQuery.of(context).size;
    double companySize= (size.width/4);
    double startSize  = size.width - (companySize) - (companySize/2);//MediaQuery.of(context).orientation == Orientation.portrait ? size.width - (companySize) - (companySize/6) : size.width - (companySize) - (companySize/6);

    return Padding(
      padding: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
      child: Card(
        elevation: 3.0,
        color: Theme.of(context).cardColor,
        borderOnForeground: true,
        child: Padding(
          padding: EdgeInsets.only(
            top: 15.0,
            bottom: 0,
          ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Agendamento #' + widget.schudule.idSchudule.toString().padLeft(4,'0'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Roboto',
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                widget.schudule.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Roboto',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                '\n',
              ),

              // Botões de ação
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  SizedBox(
                    width: companySize,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).backgroundColor,
                      child: FaIcon(FontAwesomeIcons.solidAddressCard),
                      onPressed: (){
                        if(widget.schudule.idSubsidiary == null) {
                          Message(context).error('O administrador do sistema não inseriu uma filial válida! Verifique.', tempo: 2);
                        }
                        else {
                          Navigator.of(context).push(FadePageRoute(SubsidiaryPage(
                            Provider.of<App>(context, listen: false).listSubsidiary.firstWhere((element) => (element.id == widget.schudule.idSubsidiary))
                          )));
                        }
                      },
                    ),
                  ),

                  SizedBox(
                    width: startSize,
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).backgroundColor,
                      child: FaIcon(FontAwesomeIcons.solidPlayCircle),
                      onPressed: (){
                        if(widget.schudule.listItemSchudule.length <= 0){
                          Message(context).error('Agendamento não possui marcações! Verifique com o responsável pelo cadastro.', tempo: 2);
                        } // if(widget.schudule.listItemSchudule.length <= 0){ ... }
                        else {
                          Navigator.of(context).push(FadePageRoute(SchuduleItemPage(widget.schudule.idSchudule))).then((value){
                            // Ao final atualiza os dados nos componentes
                            //ImageDao.getAllDB(context).then((value) => print(value));
                            setState(() {});
                          });
                        } // else { ... }
                      },
                    ),
                  ),
                ],
              ),
            ],
          )
        ),
      ),
    );

  } // Widget build(BuildContext context) { ... }
}