import 'dart:convert';
import 'dart:io';

import 'package:epraga/allFiles.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';


class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  SchuduleItem schuduleItem;

  CameraPage(this.cameras, this.schuduleItem, {Key key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController controller;
  int nowCamera = 1, quarterTurns = 0;

  @override
  void initState() {
    super.initState();
    _onButtonChangeCameraPressed();
  }

  @override
  Widget build(BuildContext context) {

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

    return WillPopScope(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: Colors.black,
              child: RotatedBox(
                quarterTurns: quarterTurns,
                child: _cameraPreViewWidget(),
              ),
            ),
            Positioned(
              bottom: 18.0,
              child: _bottomBarWidget(context),
            ),
          ],
        ),
      ),
      onWillPop: (){
        Navigator.of(context).pop();
      },
    );
  }


  Widget _cameraPreViewWidget() {
    return Center(
      child: !controller.value.isInitialized
          ? null
          : AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: CameraPreview(controller),
            ),
    );
  }

  Widget _bottomBarWidget(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 3.0,
        child: Container(
          width: size.width - (size.width/4),
          padding: EdgeInsets.only(
            top: 5.0,
            bottom: 5.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

              Text(
                '#'+ widget.schuduleItem.id.toString().trim().padLeft(4,'0') + ' - ' + widget.schuduleItem.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

              Padding(
                padding: EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.blue,
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
                        _onButtonTakePhotoPressed(context);
                      },
                      color: Colors.blue,
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
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _onButtonChangeCameraPressed() async {
    nowCamera = nowCamera == 0 ? 1 : 0;
    CameraDescription cameraDescription = widget.cameras[nowCamera];
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);
    controller.addListener(() {
      if (mounted) setState(() {});
    });
    await controller.initialize();
    if (mounted) setState(() {});
  } // void _onButtonChangeCameraPressed() async { ... }

  void _onButtonTakePhotoPressed(BuildContext context) async {
    if (!controller.value.isInitialized) {
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/ePraga';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/IMG_${DateTime.now().millisecondsSinceEpoch}.jpg';

    if (controller.value.isTakingPicture) {
      return null;
    }
    await controller.takePicture(filePath);
    File imageFile        = new File(filePath);
    List<int> imageBytes  = imageFile.readAsBytesSync();

    ImageBase64 imgBase64 = ImageBase64(
      base64: base64Encode(imageBytes),
      idSchuduleItem: widget.schuduleItem.id,
      latitude: 99.9999,
      longitude: 99.9999,
      execUpdate: true,
      lastAlt: DateTime.now(),
    );

    Provider.of<ListData>(context, listen: false).listSchudule.where((element) => element.id == widget.schuduleItem.idSchudule).first.schuduleItem.where((element) => (element.id == widget.schuduleItem.id)).first.images.add(imgBase64);
    Navigator.pop(context);

    //createPhotoData(filePath);
  }
}