import 'dart:convert';

import 'package:epraga/allFiles.dart';
import 'package:epraga/config/config.dart' as config;
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class SenderController {
  static Future<bool> senderLocation(BuildContext context) async{
    try {
      Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      Map<String, dynamic> data = Map<String, dynamic>();
      data.putIfAbsent('latitude', () => position.latitude.toString());
      data.putIfAbsent('longitude', () => position.longitude.toString());
      data.putIfAbsent('speed', () => position.speed.toString());
      


      Sender tmpSender  = Sender();
      tmpSender.url     = config.ENDPOINT_LOCATION;
      tmpSender.content = data.toString();

      await SenderDao.setDB(context, tmpSender);

      return true;
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[SenderController][senderLocation] -----------');
        print(error);
        print('[SenderController][senderLocation] -----------');
      }
      return false;
    } // catch(error) { ... }
  } // static Future<bool> senderLocation(BuilderContext context) { ... }


  static Future<bool> senderSchudule(BuildContext context, ItemSchudule itemSchudule) async {
    try {
      ItemSchudule schudule = Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == itemSchudule.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == itemSchudule.idItemSchudule));
      Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      Map<String, dynamic> data = Map<String, dynamic>();
      data.putIfAbsent('latitude', () => position.latitude.toString());
      data.putIfAbsent('longitude', () => position.longitude.toString());
      data.putIfAbsent('speed', () => position.speed.toString());
      data.putIfAbsent('id_schudule', () => schudule.idSchudule);
      data.putIfAbsent('id_schudule_item', () => schudule.idItemSchudule);


      Sender tmpSender  = Sender();
      tmpSender.url     = config.ENDPOINT_ITEM;
      tmpSender.content = data.toString();

      await SenderDao.setDB(context, tmpSender);

      return true;
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[SenderController][senderSchudule] -----------');
        print(error);
        print('[SenderController][senderSchudule] -----------');
      }
      return false;
    } // catch(error) { ... }
  } // static Future<bool> senderSchudule(BuildContext context, ItemSchudule itemSchudule) async { ... }

  static Future<bool> senderImage(BuildContext context, ItemSchudule itemSchudule) async {
    try {
      List<ImgSchudule> schudule = Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == itemSchudule.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == itemSchudule.idItemSchudule)).listImages;
      Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      
      for(int i=0; i<schudule.length; i++) {
        
        Map<String, dynamic> data = Map<String, dynamic>();
        data.putIfAbsent('latitude', () => position.latitude.toString());
        data.putIfAbsent('longitude', () => position.longitude.toString());
        data.putIfAbsent('id_schudule_item', () => itemSchudule.idItemSchudule);
        data.putIfAbsent('base64', () => schudule.elementAt(i).base64);

        Sender tmpSender  = Sender();
        tmpSender.url     = config.ENDPOINT_IMG;
        tmpSender.content = data.toString();

        await SenderDao.setDB(context, tmpSender);
      } // for(int i=0; i<schudule.length; i++) { ... }

      return true;
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[SenderController][senderImage] -----------');
        print(error);
        print('[SenderController][senderImage] -----------');
      }
      return false;
    } // catch(error) { ... }
  } // static Future<bool> senderSchudule(BuildContext context, ItemSchudule itemSchudule) async { ... }

  static Future<bool> senderQuestions(BuildContext context, ItemSchudule itemSchudule) async {
    try {
      Question schudule = Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == itemSchudule.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == itemSchudule.idItemSchudule)).listQuestions;
      Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      
      Map<String, dynamic> data = {
        'latitude'  : position.latitude,
        'longitude' : position.longitude,
        'visit'     : schudule.listVisit.where((element) => (element.counter > 0)),
        'used'      : schudule.listProd.where((element) => (element.counter > 0)),
        'iscas'     : schudule.sitIsca,
        'conform'   : schudule.naoConform,
        'iscaSit'   : schudule.iscaSubstituida,
        'ambiente'  : schudule.ambienteAdequado,
        'listIsca'  : schudule.listIsca,
        'listConf'  : schudule.listConform,
      };


      Sender tmpSender  = Sender();
      tmpSender.url     = config.ENDPOINT_ITEM;
      tmpSender.content = data.toString();

      await SenderDao.setDB(context, tmpSender);

      return true;
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[SenderController][senderQuestions] -----------');
        print(error);
        print('[SenderController][senderQuestions] -----------');
      }
      return false;
    } // catch(error) { ... }
  } // static Future<bool> senderSchudule(BuildContext context, ItemSchudule itemSchudule) async { ... }


  static Future<bool> senderData(BuildContext context) async {
    try {
      List<Sender> listSender = await SenderDao.getDB(context);
      Login login = Provider.of<App>(context).login;
      // Se tem rede, então primeiramente procura na rede
      // Monta os headers da requisição
      Map<String, String> headers  = Map<String, String>();
      headers.putIfAbsent('accept',       () => 'application/json');
      headers.putIfAbsent('Authorization',() => 'Bearer ' + Provider.of<App>(context, listen: false).login.hash);

      for(int i=0;i<listSender.length;i++) {
        final response  = await http.post(
          listSender.elementAt(i).url,
          headers: headers,
          body: jsonDecode(listSender.elementAt(i).content),
        );

        if(response.statusCode == 200) {
          await SenderDao.deleteDB(context, listSender.elementAt(i));
        }
      } // for(int i=0;i<listSender.length;i++) { ... }

      return true;
    }
    catch(error) {
      if(config.DEBUG) {
        print('[SenderController][senderData] -----------------');
        print(error);
        print('[SenderController][senderData] -----------------');
      }
      return false;
    }
  } // static Future senderData(BuildContext context) { ... }
} // class SenderController { ... }