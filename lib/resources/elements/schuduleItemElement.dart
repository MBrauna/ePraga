import 'package:epraga/allFiles.dart';

// ignore: must_be_immutable
class SchuduleItemElement extends StatefulWidget {
  int idSchudule, idxSchuduleItem;
  SchuduleItemElement(this.idSchudule, this.idxSchuduleItem);

  @override
  _SchuduleItemElement createState() => _SchuduleItemElement();
} // class SchuduleItemElement extends StatefulWidget { ... }

class _SchuduleItemElement extends State<SchuduleItemElement> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardData = (size.width/2.5);

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
            color: Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(widget.idxSchuduleItem).accept ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
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
                Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(widget.idxSchuduleItem).description,
                softWrap: true,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18.0,
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
                        Navigator.of(context).push(FadePageRoute(ImagePage(Provider.of<App>(context, listen: false).cameraList,Provider.of<App>(context,listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.idSchudule)).listItemSchudule.elementAt(widget.idxSchuduleItem))));
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
                      onPressed: (){},
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
                  onPressed: (){},
                ),
              ),
            
            ],
          ),
        ),
      ),
    );
  }
} // class _SchuduleItemElement extends State<SchuduleItemElement> { ... }