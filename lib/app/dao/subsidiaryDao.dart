import 'package:epraga/allFiles.dart';
import 'package:epraga/config/config.dart' as config;

class SubsidiaryDao {
  static Future<bool> setData(BuildContext context, Subsidiary subsidiary) async {
    try {
      // Procura se o registro existe na base.
      List<Subsidiary> listExist  = await SubsidiaryDao.getDB(context, subsidiary.id);

      if(listExist.length > 0) {
        await SubsidiaryDao.deleteDB(context, subsidiary);
      }

      await Provider.of<App>(context, listen: false).database.insert('subsidiary',{
        'id_subsidiary'   : subsidiary.id,
        'id_company'      : subsidiary.idCompany,
        'name'            : subsidiary.name,
        'company'         : subsidiary.company,
        'description'     : subsidiary.description,
        'address'         : subsidiary.address,
        'latitude'        : subsidiary.latitude,
        'longitude'       : subsidiary.longitude,
        'croqui'          : subsidiary.croqui,
      }); // Provider.of<App>(context).database.insert('subsidiary',{ ...});

      return true;
    } // try { ... }
    catch(error) {
      if(config.DEBUG){
        print('[SubsidiaryDao][setData] ----------');
        print(error);
        print('[SubsidiaryDao][setData] ----------');
      } // if(config.DEBUG){ ... }
      return false;
    } // catch(error) { ... }
  } // static Future<bool> setData(BuildContext context, Subsidiary subsidiary) { ... }

  static Future<List<Subsidiary>> getDB(BuildContext context, int id) async {
    try {
      // Prepara o retorno para os dados
      List<Subsidiary> listReturn = List<Subsidiary>();

      // Coleta do banco os dados obtidos do ID
      List<Map<String, dynamic>> dbReturn = await Provider.of<App>(context,listen: false).database.query(
        'subsidiary',
        distinct: true,
        where: '((? = null) or (id_subsidiary = ?))',
        whereArgs: [
          id,
          id,
        ],
        orderBy: 'id_subsidiary'
      );

      dbReturn.forEach((element) {
        Subsidiary tmpSubsidiary  = Subsidiary.fromDB(element);
        listReturn.add(tmpSubsidiary);
      });

      return listReturn;
    } // try { ... }
    catch(error) {
      if(config.DEBUG){
        print('[SubsidiaryDao][getData] ----------');
        print(error);
        print('[SubsidiaryDao][getData] ----------');
      } // if(config.DEBUG){ ... }
      List<Subsidiary> listReturn = List<Subsidiary>();
      return listReturn;
    } // catch(error) { ... }
  } // static Future<List<Schudule>> getData(BuildContext context, int id) { ... }

  static Future<List<Subsidiary>> getAllDB(BuildContext context) async {
    try {
      // Prepara o retorno para os dados
      List<Subsidiary> listReturn = List<Subsidiary>();

      // Coleta do banco os dados obtidos do ID
      List<Map<String, dynamic>> dbReturn = await Provider.of<App>(context,listen: false).database.query(
        'subsidiary',
        distinct: true,
        orderBy: 'id_subsidiary'
      );

      dbReturn.forEach((element) {
        Subsidiary tmpSubsidiary  = Subsidiary.fromDB(element);
        listReturn.add(tmpSubsidiary);
      });

      return listReturn;
    } // try { ... }
    catch(error) {
      if(config.DEBUG){
        print('[SubsidiaryDao][getAllData] ----------');
        print(error);
        print('[SubsidiaryDao][getAllData] ----------');
      } // if(config.DEBUG){ ... }
      List<Subsidiary> listReturn = List<Subsidiary>();
      return listReturn;
    } // catch(error) { ... }
  } // static Future<List<Schudule>> getAllData(BuildContext context) { ... }

  static Future<bool> deleteDB(BuildContext context, Subsidiary subsidiary) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('subsidiary',
        where: 'id_subsidiary = ?',
        whereArgs: [
          subsidiary.id,
        ],
      );

      return true;
    }
    catch(error){
      if(config.DEBUG){
        print('[SubsidiaryDao][deleteDB] ----------');
        print(error);
        print('[SubsidiaryDao][deleteDB] ----------');
      } // if(config.DEBUG){ ... }
      return false;
    }
  } // static Future<bool> deleteDB(BuildContext context, Subsidiary subsidiary) { ... }

  static Future<bool> deleteAllDB(BuildContext context) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('subsidiary');

      return true;
    }
    catch(error){
      if(config.DEBUG){
        print('[SubsidiaryDao][deleteAllDB] ----------');
        print(error);
        print('[SubsidiaryDao][deleteAllDB] ----------');
      } // if(config.DEBUG){ ... }
      return false;
    }
  } // static Future<bool> deleteAllDB(BuildContext context, Subsidiary subsidiary) { ... }
} // class SubsidiaryDao { ... }