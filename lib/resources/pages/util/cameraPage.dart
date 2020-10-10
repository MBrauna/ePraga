import 'dart:io';

import 'package:epraga/allFiles.dart';
import 'package:camera/camera.dart';


// ignore: must_be_immutable
class CameraPage extends StatefulWidget {
  List<CameraDescription> cameras;
  ItemSchudule schuduleItem;

  CameraPage(this.cameras, this.schuduleItem, {Key key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController controller;
  int nowCamera = 1, quarterTurns = 0;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

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
      // ignore: missing_return
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
                'Teste',//'#'+ widget.s.toString().trim().padLeft(4,'0') + ' - ' + widget.schuduleItem.description,
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
                      onPressed: _onButtonChangeCameraPressed,
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
    File imageFile          = new File(filePath);

    ImgSchudule imgBase64   = ImgSchudule();
    imgBase64.base64        = 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8/5+hHgAHggJ/PchI7wAAAABJRU5ErkJggg==';// base64Encode(imageBytes);
    imgBase64.idImgSchudule = null;
    imgBase64.idItemSchudule= widget.schuduleItem.idItemSchudule;
    Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == widget.schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == widget.schuduleItem.idItemSchudule)).listImages.add(imgBase64);

    Navigator.of(context).pop();

    //createPhotoData(filePath);
  }
}