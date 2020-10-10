import 'package:epraga/allFiles.dart';
import 'package:epraga/config/config.dart' as config;

class SenderDao {
  static Future<bool> setDB(BuildContext context, Sender sender) async {
    try {
      await Provider.of<App>(context, listen: false).database.insert('sender',{
        'id'      : sender.id,
        'url'     : sender.url,
        'content' : sender.content,
        'status'  : sender.status ? 1 : 0,
      }); // Provider.of<App>(context).database.insert('login',{ ...});
    }
    catch(error) {
      if(config.DEBUG) {
        print('[SenderDao][setDB] -------------');
        print(error);
        print('[SenderDao][setDB] -------------');
      }
      return false;
    }
  } // static Future<bool> setDB(BuildContext context, Sender sender) async { ... }

  static Future<List<Sender>> getDB(BuildContext context) async {
    List<Sender> dataReturn  = List<Sender>();

      List<Map<String, dynamic>> dbReturn = await Provider.of<App>(context,listen: false).database.query(
        'sender',
        distinct: true,
        orderBy: 'id'
      );

      dbReturn.forEach((element) {
        try {
          Sender tmpSender  =  Sender();
          tmpSender.id      = element['id'];
          tmpSender.url     = element['url'];
          tmpSender.content = element['content'];
          tmpSender.status  = element['status'] == 1 ? true : false;

          dataReturn.add(tmpSender);
        } // try { ... }
        catch(error) {
          if(config.DEBUG) {
            print('[SenderDao][getDB] -----');
            print(error);
            print(element);
            print('[SenderDao][getDB] -----');
          }
        } // catch(error) { ... }
      }); // dbReturn.forEach((element) { ... });

      return dataReturn;
  } // static Future<List<Sender>> getDB(BuildContext context) { ... }

  static Future<bool> deleteDB(BuildContext context, Sender sender) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('sender',
        where: 'id = ?',
        whereArgs: [
          sender.id,
        ],
      );

      return true;
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[SenderDao][deleteDB] -----');
        print(error);
        print('[SenderDao][deleteDB] -----');
      }

      return false;
    } // catch(error) { ... }
  } // static Future<bool> deleteDB(BuildContext context, Sender sender) async { ... }

  static Future<bool> deleteAllDB(BuildContext context, Sender sender) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('sender');

      return true;
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[SenderDao][deleteAllDB] -----');
        print(error);
        print('[SenderDao][deleteAllDB] -----');
      }

      return false;
    } // catch(error) { ... }
  } // static Future<bool> deleteDB(BuildContext context, Sender sender) async { ... }
}