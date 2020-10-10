import 'package:epraga/allFiles.dart';
import 'package:epraga/config/config.dart' as config;

class LoginDao {
  static Future<bool> setDB(BuildContext context, Login login) async {
    try {
      await LoginDao.deleteAllDB(context);

      await Provider.of<App>(context, listen: false).database.insert('login',{
        'id'            : login.id,
        'name'          : login.name,
        'cpf_cnpj'      : login.cpfCnpj,
        'hash'          : login.hash,
        'last_login'    : login.last == null ? DateTime.now().millisecondsSinceEpoch : login.last.millisecondsSinceEpoch,
        'expired_login' : login.expire.millisecondsSinceEpoch,
      }); // Provider.of<App>(context).database.insert('login',{ ...});

      return true;
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[LoginDao][setDB] ---------');
        print(error);
        print('[LoginDao][setDB] ---------');
      }
      return false;
    } // catch(error) { ... }
  } // static Future<bool> setDB(Login login) { ... }

  static Future<List<Login>> getDB(BuildContext context) async {
    try {
      List<Login> dataReturn  = List<Login>();

      List<Map<String, dynamic>> dbReturn = await Provider.of<App>(context,listen: false).database.query(
        'login',
        distinct: true,
        orderBy: 'id'
      );

      dbReturn.forEach((element) {
        try {
          Login tmpLogin  = Login();
          tmpLogin.id     = element['id'];
          tmpLogin.name   = element['name'];
          tmpLogin.hash   = element['hash'];
          tmpLogin.cpfCnpj= element['cpf_cnpj'];
          tmpLogin.last   = (element['last_login'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(element['last_login']));
          tmpLogin.expire = (element['expired_login'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(element['expired_login']));


          dataReturn.add(tmpLogin);
        } // try { ... }
        catch(error) {
          if(config.DEBUG) {
            print('[LoginDao][getDB] -----');
            print(error);
            print(element);
            print('[LoginDao][getDB] -----');
          }
        } // catch(error) { ... }
      }); // dbReturn.forEach((element) { ... });

      return dataReturn;
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[LoginDao][getDB] -----');
        print(error);
        print('[LoginDao][getDB] -----');
      }
      List<Login> dataReturn  = List<Login>();
      return dataReturn;
    } // catch(error) { ... }
  } // static Future<bool> getDB(BuildContext context) { ... }

  static Future<bool> deleteDB(BuildContext context, Login login) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('login',
        where: 'id = ?',
        whereArgs: [
          login.id,
        ],
      );

      return true;
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[LoginDao][deleteDB] -----');
        print(error);
        print('[LoginDao][deleteDB] -----');
      }

      return false;
    } // catch(error) { ... }
  } // static Future<bool> deleteDB() async { ... }

  static Future<bool> deleteAllDB(BuildContext context) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('login');

      return true;
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[LoginDao][deleteAllDB] -----');
        print(error);
        print('[LoginDao][deleteAllDB] -----');
      }

      return false;
    } // catch(error) { ... }
  } // static Future<bool> deleteAllDB() async { ... }
} // class LoginDao { ... }