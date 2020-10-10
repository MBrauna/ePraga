import 'package:epraga/allFiles.dart';
import 'package:epraga/config/config.dart' as config;

class SchuduleDao {
  static Future<bool> setData(BuildContext context, Schudule schudule) async {
    try {

      // Procura se o registro existe na base.
      List<Schudule> listExist  = await SchuduleDao.getDB(context, schudule.idSchudule);

      /*schudule.listItemSchudule.forEach((element) {
        SchuduleItemDao.setDB(context, element);
      });*/

      if(listExist.length <= 0) {
        await Provider.of<App>(context, listen: false).database.insert('schudule',{
          'id_schudule'   : schudule.idSchudule,
          'id_subsidiary' : schudule.idSubsidiary,
          'description'   : schudule.description,
          'last_alt'      : schudule.lastAlt.millisecondsSinceEpoch,
          'status'        : (schudule.status ? 1 : 0),
        }); // Provider.of<App>(context).database.insert('login',{ ...});
      }
      else if(listExist.length == 1) {
        // Verifica se a última alteração do registro foi depois deste sofrer alguma adição
        if(listExist.first.lastAlt.millisecondsSinceEpoch < schudule.lastAlt.millisecondsSinceEpoch) {
          // Se for ... substitui o dado existente
          SchuduleDao.deleteDB(context, schudule);

          // Insere o novo registro
          await Provider.of<App>(context, listen: false).database.insert('schudule',{
            'id_schudule'   : schudule.idSchudule,
            'id_subsidiary' : schudule.idSubsidiary,
            'description'   : schudule.description,
            'last_alt'      : schudule.lastAlt.millisecondsSinceEpoch,
            'status'        : (schudule.status ? 1 : 0),
          }); // Provider.of<App>(context).database.insert('login',{ ...});
        } // if(listExist.first.lastAlt.millisecondsSinceEpoch < schudule.lastAlt.millisecondsSinceEpoch) { ... }
      }
      else {
        // Remove todos os registros, pois não deveria ter mais de 1
        for(int i=0; i<listExist.length; i++){
          await SchuduleDao.deleteDB(context, listExist.elementAt(i));
        } // for(int i=0; i<listExist.length; i++){ ... }

        // Insere o novo registro
        await Provider.of<App>(context, listen: false).database.insert('schudule',{
          'id_schudule'   : schudule.idSchudule,
          'id_subsidiary' : schudule.idSubsidiary,
          'description'   : schudule.description,
          'last_alt'      : schudule.lastAlt.millisecondsSinceEpoch,
          'status'        : (schudule.status ? 1 : 0),
        }); // Provider.of<App>(context).database.insert('login',{ ...});
      } // else { ... }

      

      return true;
    } // try { ... }
    catch(error){
      if(config.DEBUG){
        print('[SchuduleDao][setData] -------');
        print(error);
        print('[SchuduleDao][setData] -------');
      } // if(config.DEBUG){ ... }

      return false;
    } // catch(error){ ... }
  } // static Future<bool> setData(BuildContext context, Schudule schudule) { ... }

  static Future<List<Schudule>> getDB(BuildContext context, int id) async {
    try {
      List<Schudule> schuduleList = List<Schudule>();

      List<Map<String, dynamic>> dbReturn = await Provider.of<App>(context,listen: false).database.query(
        'schudule',
        distinct: true,
        where: '((? = null) or (id_schudule = ?))',
        whereArgs: [
          id,
          id,
        ],
        orderBy: 'id_schudule'
      );

      for(int i=0; i<dbReturn.length; i++){
        // Marca o Schudule
        Schudule tmpSchudule          = Schudule();
        tmpSchudule.idSchudule        = dbReturn.elementAt(i)['id_schudule'];
        tmpSchudule.idSubsidiary      = dbReturn.elementAt(i)['id_subsidiary'];
        tmpSchudule.description       = dbReturn.elementAt(i)['description'];
        tmpSchudule.lastAlt           = dbReturn.elementAt(i)['last_alt'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(dbReturn.elementAt(i)['last_alt']);
        tmpSchudule.status            = dbReturn.elementAt(i)['status'] == 1 ? true : false;
        tmpSchudule.listItemSchudule  = List<ItemSchudule>();//   await Schudule(context, dbReturn.elementAt(i)['id_schudule']);

        schuduleList.add(tmpSchudule);
      }

      return schuduleList; 
    } // try { ... }
    catch(error) {
      if(config.DEBUG){
        print('[SchuduleDao][getDB] ------');
        print(error);
        print('[SchuduleDao][getDB] ------');
      } // if(config.DEBUG){ ... }

      List<Schudule> returnDB = List<Schudule>();
      return returnDB;
    } // catch(error) { ... }
  } // static Future<List<Schudule>> getDB(BuildContext context) async { ... }

  static Future<List<Schudule>> getAllDB(BuildContext context) async {
    try {
      List<Schudule> schuduleList = List<Schudule>();

      List<Map<String, dynamic>> dbReturn = await Provider.of<App>(context,listen: false).database.query(
        'schudule',
        distinct: true,
        orderBy: 'id_schudule'
      );

      for(int i=0; i<dbReturn.length; i++){
        // Marca o Schudule
        Schudule tmpSchudule          = Schudule();
        tmpSchudule.idSchudule        = dbReturn.elementAt(i)['id_schudule'];
        tmpSchudule.idSubsidiary      = dbReturn.elementAt(i)['id_subsidiary'];
        tmpSchudule.description       = dbReturn.elementAt(i)['description'];
        tmpSchudule.lastAlt           = dbReturn.elementAt(i)['last_alt'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(dbReturn.elementAt(i)['last_alt']);
        tmpSchudule.status            = dbReturn.elementAt(i)['status'] == 1 ? true : false;
        tmpSchudule.listItemSchudule  = List<ItemSchudule>();//await Schudule(context, dbReturn.elementAt(i)['id_schudule']);

        schuduleList.add(tmpSchudule);
      }

      return schuduleList; 
    } // try { ... }
    catch(error) {
      if(config.DEBUG){
        print('[SchuduleDao][getDB] ------');
        print(error);
        print('[SchuduleDao][getDB] ------');
      } // if(config.DEBUG){ ... }

      List<Schudule> returnDB = List<Schudule>();
      return returnDB;
    } // catch(error) { ... }
  } // static Future<List<Schudule>> getDB(BuildContext context) async { ... }

  static Future<bool> deleteDB(BuildContext context, Schudule schudule) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('schudule',
        where: 'id_schudule = ?',
        whereArgs: [
          schudule.idSchudule,
        ],
      );

      //await SchuduleItemDao.deleteSchuduleDB(context, schudule);

      return true;
    }
    catch(error) {
      if(config.DEBUG){
        print('[SchuduleDao][deleteDB] ------');
        print(error);
        print('[SchuduleDao][deleteDB] ------');
      } // if(config.DEBUG){ ... }

      return false;
    }
  } // static Future<bool> deleteDB(BuildContext context, Schudule schudule) async { ... }

  static Future<bool> deleteAllDB(BuildContext context) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('schudule');
      //await SchuduleItemDao.deleteAllDB(context);

      return true;
    }
    catch(error) {
      if(config.DEBUG){
        print('[SchuduleDao][deleteAllDB] ------> *');
        print(error);
        print('[SchuduleDao][deleteAllDB] ------> *');
      } // if(config.DEBUG){ ... }

      return false;
    }
  } // static Future<bool> deleteDB(BuildContext context, Schudule schudule) async { ... }
}