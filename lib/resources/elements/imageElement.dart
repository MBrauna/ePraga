import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:epraga/allFiles.dart';

// ignore: must_be_immutable
class ImageElement extends StatefulWidget {
  ItemSchudule itemSchudule;
  ImgSchudule imageSchudule;

  ImageElement(this.itemSchudule, this.imageSchudule);

  @override
  _ImageElement createState() => _ImageElement();
} // class ImageElement extends StatefulWidget { ... }

class _ImageElement extends State<ImageElement> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sizeCard = (size.width/2.6);
    
    return Padding(
      padding: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
      child: Container(
        width: double.infinity,
        child: Card(
          elevation: 3.0,
          child: Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              bottom: 5.0,
              left: 10.0,
              right: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                // --------------------------------- //
                Container(
                  width: sizeCard,
                  alignment: Alignment.center,
                  child: Image.memory(
                    Base64Decoder().convert(widget.imageSchudule.base64),
                  ),
                ),
                // --------------------------------- //
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Data: ' + DateFormat('dd/MM/yyyy kk:mm').format(widget.imageSchudule.createdAt),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      widget.imageSchudule.idImgSchudule == null ? 'Aguardando envio' : 'Enviado ID #' + widget.imageSchudule.idImgSchudule.toString().padLeft(7,'0'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(
                      width: sizeCard,
                      child: RaisedButton(
                        color: Theme.of(context).errorColor,
                        child: FaIcon(
                          FontAwesomeIcons.solidTrashAlt,
                          color: Theme.of(context).backgroundColor,
                        ),
                        onPressed: () async{
                          await ImageDao.deleteImageDB(context, widget.imageSchudule);
                          List<ImgSchudule> listSchudule  = await ImageDao.getDB(context, widget.itemSchudule.idItemSchudule);
                          setState((){
                            Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.itemSchudule.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.itemSchudule.idItemSchudule)).listImages = listSchudule;
                          });
                        },
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        )
      ),
    );
  }
} // class _ImageElement extends State<ImageElement> { ... }