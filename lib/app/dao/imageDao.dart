import 'package:epraga/allFiles.dart';
import 'package:epraga/config/config.dart' as config;

class ImageDao {
  static Future<bool> setDB(BuildContext context, ImgSchudule imgSchudule) async {
    try {
      List<ImgSchudule> dbReturn = await ImageDao.getDB(context, imgSchudule.idItemSchudule);

      dbReturn.forEach((element) {
        if((element.idItemSchudule == imgSchudule.idItemSchudule) && (element.base64 == imgSchudule.base64)) {
          ImageDao.deleteImageDB(context, imgSchudule);
        } // if((element.idItemSchudule == imgSchudule.idItemSchudule) && (element.base64 == imgSchudule.base64)) { ... }
      });
      
      await Provider.of<App>(context, listen: false).database.insert('image',{
        'id'                : DateTime.now().millisecondsSinceEpoch,
        'id_img_schudule'   : imgSchudule.idImgSchudule,
        'id_schudule_item'  : imgSchudule.idItemSchudule,
        'base64img'         : imgSchudule.base64,
        'created_at'        : imgSchudule.createdAt == null ? DateTime.now().millisecondsSinceEpoch : imgSchudule.createdAt.millisecondsSinceEpoch,
      }); // Provider.of<App>(context).database.insert('login',{ ...});
      
      return true;
    }
    catch(error){
      if(config.DEBUG){
        print('[ImageDao][setDB] ---------');
        print(error);
        print('[ImageDao][setDB] ---------');
      }
      return false;
    }
  } // static Future<bool> setDB(BuildContext context, ImgSchudule image) { ... }

  static Future<List<ImgSchudule>> getDB(BuildContext context, int itemSchudule) async {
    try {
      List<ImgSchudule> listSchudule  = List<ImgSchudule>();

      List<Map<String, dynamic>> dbReturn = await Provider.of<App>(context,listen: false).database.query(
        'image',
        where: 'id_schudule_item = ?',
        whereArgs: [
          itemSchudule,
        ],
        orderBy: 'created_at asc'
      );

      dbReturn.forEach((element) {
        ImgSchudule imageTmp    = ImgSchudule();
        imageTmp.idImgSchudule  = element['id_img_schudule'];
        imageTmp.idItemSchudule = element['id_schudule_item'];
        imageTmp.base64         = element['base64img'];
        imageTmp.createdAt      = element['created_at'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(element['created_at']);
        listSchudule.add(imageTmp);
      });

      return listSchudule;
    }
    catch(error, stacktrace) {
      if(config.DEBUG){
        print('[ImageDao][getDB] ----------');
        print(error);
        print(stacktrace);
        print('[ImageDao][getDB] ----------');
      } // if(config.DEBUG){ ... }

      return List<ImgSchudule>();
    }
  } // static Future<List<ImgSchudule>> getDB() async { ... }

  static Future<List<ImgSchudule>> getAllDB(BuildContext context) async {
    try {
      List<ImgSchudule> listSchudule  = List<ImgSchudule>();

      List<Map<String, dynamic>> dbReturn = await Provider.of<App>(context,listen: false).database.query('image');

      dbReturn.forEach((element) {
        ImgSchudule imageTmp    = ImgSchudule();
        imageTmp.idImgSchudule  = element['id_img_schudule'];
        imageTmp.idItemSchudule = element['id_schudule_item'];
        imageTmp.base64         = element['base64img'];
        imageTmp.createdAt      = element['created_at'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(element['created_at']);

        listSchudule.add(imageTmp);
      });

      return listSchudule;
    }
    catch(error) {
      if(config.DEBUG){
        print('[ImageDao][getDB] ----------');
        print(error);
        print('[ImageDao][getDB] ----------');
      } // if(config.DEBUG){ ... }

      return List<ImgSchudule>();
    }
  } // static Future<List<ImgSchudule>> getDB() async { ... }

  static Future<bool> deleteDB(BuildContext context, ItemSchudule itemSchudule) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('image',
        where: 'id_schudule_item = ?',
        whereArgs: [
          itemSchudule.idItemSchudule,
        ],
      );

      return true;
    }
    catch(error){
      if(config.DEBUG){
        print('[ImageDao][deleteDB] ----------');
        print(error);
        print('[ImageDao][deleteDB] ----------');
      } // if(config.DEBUG){ ... }
      return false;
    }
  } // static Future<bool> deleteDB(BuildContext context, Subsidiary subsidiary) { ... }

  static Future<bool> deleteImageDB(BuildContext context, ImgSchudule imgSchudule) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('image',
        where: 'base64img = ? and id_schudule_item = ?',
        whereArgs: [
          imgSchudule.base64,
          imgSchudule.idItemSchudule,
        ],
      );

      return true;
    }
    catch(error){
      if(config.DEBUG){
        print('[ImageDao][deleteImageDB] ----------');
        print(error);
        print('[ImageDao][deleteImageDB] ----------');
      } // if(config.DEBUG){ ... }
      return false;
    }
  } // static Future<bool> deleteDB(BuildContext context, Subsidiary subsidiary) { ... }

  static Future<bool> deleteAllDB(BuildContext context) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('image');

      return true;
    }
    catch(error){
      if(config.DEBUG){
        print('[ImageDao][deleteAllDB] ----------');
        print(error);
        print('[ImageDao][deleteAllDB] ----------');
      } // if(config.DEBUG){ ... }
      return false;
    }
  } // static Future<bool> deleteDB(BuildContext context, Subsidiary subsidiary) { ... }
} // class ImageDao { ... }