import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:compressimage/compressimage.dart';
import 'package:epraga/allFiles.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';

// ignore: must_be_immutable
class ImagePage extends StatefulWidget {
  List<CameraDescription> cameras;
  ItemSchudule schuduleItem;
  ImagePage(this.cameras,this.schuduleItem);

  @override
  _ImagePage createState() => _ImagePage();
}

class _ImagePage extends State<ImagePage>{
  List<CameraDescription> cameras;
  CameraController controller;
  Future<void> _initializeControllerFuture;
  int nowCamera = 1, quarterTurns = 0;
  

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras.first,
      ResolutionPreset.low,
      enableAudio: false,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = controller.initialize();
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double altura = MediaQuery.of(context).orientation == Orientation.landscape ? (size.height/1.9) : (size.height/2.5);
    double sizeCard = (size.width/2.6);

    switch(MediaQuery.of(context).orientation){
      case Orientation.landscape:
        setState(() {
          quarterTurns  = 1;
        });
        break;
      case Orientation.portrait:
        setState(() {
          quarterTurns  = 0;
        });
        break;
      default:
        setState(() {
          quarterTurns  = -1;
        });
    } // switch(MediaQuery.of(context).orientation){ ... }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
          opacity: 1.0,
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
        child: Builder(
          builder: (context) {

            return Padding(
              padding: EdgeInsets.only(
                top: 5.0,
                bottom: 5.0,
                left: 15.0,
                right: 15.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: size.width,
                    height: altura,
                    child: FutureBuilder<void>(
                      future: _initializeControllerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return RotatedBox(
                            quarterTurns: quarterTurns,
                            child: CameraPreview(
                              controller,

                            ),
                          );
                        } else {
                          // Otherwise, display a loading indicator.
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                
                  // --------------------- //
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5.0,
                      bottom: 5.0,
                    ),
                    child: Card(
                      elevation: 3.0,
                      shape: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.0,
                        ),
                        top: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.0,
                        ),
                        left: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.0,
                        ),
                        right: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 5.0,
                          bottom: 5.0,
                          left: 15.0,
                          right: 15.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              onPressed: (){},
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: FaIcon(
                                FontAwesomeIcons.syncAlt,
                                size: 24,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            MaterialButton(
                              onPressed: (){
                                onTakePicture(context).then((value) => setState((){}));
                              },
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: FaIcon(
                                FontAwesomeIcons.cameraRetro,
                                size: 24,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                          ],
                        ),
                      )
                    ),
                  ),



                  Card(
                    elevation: 3.0,
                    shape: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                      top: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                      left: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                      right: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        'Imagens existentes na tarefa\nClique para expandir',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listImages.map((e){
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
                                        Base64Decoder().convert(e.base64),
                                      ),
                                    ),
                                    // --------------------------------- //
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Data: ' + DateFormat('dd/MM/yyyy kk:mm').format(e.createdAt),
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Text(
                                          e.idImgSchudule == null ? 'Aguardando envio' : 'Enviado ID #' + e.idImgSchudule.toString().padLeft(7,'0'),
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
                                              if(e.idImgSchudule == null) {
                                                await ImageDao.deleteImageDB(context, e);
                                                List<ImgSchudule> listSchudule  = await ImageDao.getDB(context, e.idItemSchudule);
                                                setState((){
                                                  Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == e.idItemSchudule)).listImages = listSchudule;
                                                });
                                              }
                                              else {
                                                Message(context).info('Imagem já comunicada ao servidor! Não pode ser removida.');
                                              }
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










  Future<void> onTakePicture(BuildContext context) async {
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Construct the path where the image should be saved using the
      // pattern package.
      final path = join(
        // Store the picture in the temp directory.
        // Find the temp directory using the `path_provider` plugin.
        (await getTemporaryDirectory()).path,
        'epraga_${DateTime.now().millisecondsSinceEpoch}.png',
      );

      // Attempt to take a picture and log where it's been saved.
      await controller.takePicture(path);

      // If the picture was taken, display it on a new screen.
      File imageFile          = new File(path);
      await CompressImage.compress(imageSrc: imageFile.path, desiredQuality: 80); //desiredQuality ranges from 0 to 100
      List<int> imageBytes    = imageFile.readAsBytesSync();

      ImgSchudule imgBase64   = ImgSchudule();
      imgBase64.base64        = base64Encode(imageBytes);
      imgBase64.idImgSchudule = null;
      imgBase64.idItemSchudule= widget.schuduleItem.idItemSchudule;
      imgBase64.createdAt     = DateTime.now();

      bool validate = await ImageDao.setDB(context, imgBase64);
      List<ImgSchudule> listdata = await ImageDao.getAllDB(context);
      
      if(validate) {
        Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listImages.add(imgBase64);
      }
      else {
        Message(context).error('Não foi possível armazenar a imagem! Verifique.');
      }


    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

} // class _ImagePage extends State<ImagePage> { ... }