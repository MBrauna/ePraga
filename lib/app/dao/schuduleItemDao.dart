import 'package:epraga/allFiles.dart';
import 'package:epraga/config/config.dart' as config;

class SchuduleItemDao {
  static Future<bool> setDB(BuildContext context, ItemSchudule schudule) async{
    try {

      // Procura se o registro existe na base.
      List<ItemSchudule> listExist  = await SchuduleItemDao.getDB(context, schudule.idItemSchudule);

      if(listExist.length <= 0) {
        await Provider.of<App>(context, listen: false).database.insert('schudule_item',{
          'id_schudule_item'  : schudule.idItemSchudule,
          'id_schudule'       : schudule.idSchudule,
          'spot'              : schudule.spot,
          'description'       : schudule.description,
          'last_alt'          : schudule.lastAlt == null ? DateTime.now().millisecondsSinceEpoch : schudule.lastAlt.millisecondsSinceEpoch,
          'sequence'          : schudule.sequence ?? 99,
          'qtde_images'       : schudule.qtdeImages ?? 1,
          'accept'            : schudule.accept ? 1 : 0,
          'visit'             : schudule.visit  ? 1 : 0,
        }); // Provider.of<App>(context).database.insert('login',{ ...});
      }
      else if(listExist.length == 1) {
        // Verifica se a última alteração do registro foi depois deste sofrer alguma adição
        if(listExist.first.lastAlt.millisecondsSinceEpoch < schudule.lastAlt.millisecondsSinceEpoch) {
          // Se for ... substitui o dado existente
          SchuduleItemDao.deleteDB(context, schudule);

          // Insere o novo registro
          await Provider.of<App>(context, listen: false).database.insert('schudule_item',{
            'id_schudule_item'  : schudule.idItemSchudule,
            'id_schudule'       : schudule.idSchudule,
            'spot'              : schudule.spot,
            'description'       : schudule.description,
            'last_alt'          : schudule.lastAlt == null ? DateTime.now().millisecondsSinceEpoch : schudule.lastAlt.millisecondsSinceEpoch,
            'sequence'          : schudule.sequence ?? 99,
            'qtde_images'       : schudule.qtdeImages ?? 1,
            'accept'            : schudule.accept ? 1 : 0,
            'visit'             : schudule.visit  ? 1 : 0,
          }); // Provider.of<App>(context).database.insert('login',{ ...});
        } // if(listExist.first.lastAlt.millisecondsSinceEpoch < schudule.lastAlt.millisecondsSinceEpoch) { ... }
      }
      else {
        // Remove todos os registros, pois não deveria ter mais de 1
        for(int i=0; i<listExist.length; i++){
          await SchuduleItemDao.deleteDB(context, listExist.elementAt(i));
        } // for(int i=0; i<listExist.length; i++){ ... }

        // Insere o novo registro
        await Provider.of<App>(context, listen: false).database.insert('schudule_item',{
            'id_schudule_item'  : schudule.idItemSchudule,
            'id_schudule'       : schudule.idSchudule,
            'spot'              : schudule.spot,
            'description'       : schudule.description,
            'last_alt'          : schudule.lastAlt == null ? DateTime.now().millisecondsSinceEpoch : schudule.lastAlt.millisecondsSinceEpoch,
            'sequence'          : schudule.sequence ?? 99,
            'qtde_images'       : schudule.qtdeImages ?? 1,
            'accept'            : schudule.accept ? 1 : 0,
            'visit'             : schudule.visit  ? 1 : 0,
          }); // Provider.of<App>(context).database.insert('login',{ ...});
      } // else { ... }

      return true;
    }
    catch(error){
      if(config.DEBUG){
        print('[SchuduleItemDAO][setDB] --------');
        print(error);
        print('[SchuduleItemDAO][setDB] --------');
      }
      return false;
    }
  } // static Future<bool> setDB(BuildContext context) { ... }

  static Future<List<ItemSchudule>> getDB(BuildContext context, int idItemSchudule) async {
    try {
      List<Map<String, dynamic>> dbReturn = await Provider.of<App>(context,listen: false).database.query(
        'schudule_item',
        distinct: true,
        where: '((? = null) or (id_schudule_item = ?))',
        whereArgs: [
          idItemSchudule,
          idItemSchudule,
        ],
        orderBy: 'id_schudule asc, sequence asc',
      );

      List<ItemSchudule> listSchudule = List<ItemSchudule>();
      for(int i=0; i < dbReturn.length; i++){
        ItemSchudule tmpItemSchudule  = ItemSchudule();
        tmpItemSchudule.idItemSchudule  = dbReturn.elementAt(i)['id_schudule_item'];
        tmpItemSchudule.idSchudule      = dbReturn.elementAt(i)['id_schudule'];
        tmpItemSchudule.spot            = dbReturn.elementAt(i)['spot'];
        tmpItemSchudule.description     = dbReturn.elementAt(i)['description'];
        tmpItemSchudule.lastAlt         = dbReturn.elementAt(i)['last_alt'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(dbReturn.elementAt(i)['last_alt']);
        tmpItemSchudule.listImages      = List<ImgSchudule>();// await ImageDao.getAllDB(context);
        tmpItemSchudule.listQuestions   = Question();
        tmpItemSchudule.qtdeImages      = dbReturn.elementAt(i)['qtde_images'];
        tmpItemSchudule.sequence        = dbReturn.elementAt(i)['sequence'];
        tmpItemSchudule.accept          = dbReturn.elementAt(i)['accept'] == 1 ? true : false;
        tmpItemSchudule.visit           = dbReturn.elementAt(i)['visit'] == 1 ? true : false;

        listSchudule.add(tmpItemSchudule);
      } // for(int i=0; i < dbReturn.length; i++){ ... }

      return listSchudule;
    }
    catch(error) {
      if(config.DEBUG){
        print('[SchuduleItemDAO][getDB] --------');
        print(error);
        print('[SchuduleItemDAO][getDB] --------');
      }
      return List<ItemSchudule>();
    }
  } // static Future<List<ItemSchudule>> getDB(BuildContext context) { ... }

  static Future<List<ItemSchudule>> getDBSchudule(BuildContext context, int idSchudule) async {
    try {
      List<Map<String, dynamic>> dbReturn = await Provider.of<App>(context,listen: false).database.query(
        'schudule_item',
        distinct: true,
        where: '((? = null) or (id_schudule = ?))',
        whereArgs: [
          idSchudule,
          idSchudule,
        ],
        orderBy: 'id_schudule asc, sequence asc',
      );

      List<ItemSchudule> listSchudule = List<ItemSchudule>();
      for(int i=0; i < dbReturn.length; i++){
        ItemSchudule tmpItemSchudule  = ItemSchudule();
        tmpItemSchudule.idItemSchudule  = dbReturn.elementAt(i)['id_schudule_item'];
        tmpItemSchudule.idSchudule      = dbReturn.elementAt(i)['id_schudule'];
        tmpItemSchudule.spot            = dbReturn.elementAt(i)['spot'];
        tmpItemSchudule.description     = dbReturn.elementAt(i)['description'];
        tmpItemSchudule.lastAlt         = dbReturn.elementAt(i)['last_alt'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(dbReturn.elementAt(i)['last_alt']);
        tmpItemSchudule.listImages      = List<ImgSchudule>();//await ImageDao.getAllDB(context);
        tmpItemSchudule.listQuestions   = Question();
        tmpItemSchudule.qtdeImages      = dbReturn.elementAt(i)['qtde_images'];
        tmpItemSchudule.sequence        = dbReturn.elementAt(i)['sequence'];
        tmpItemSchudule.accept          = dbReturn.elementAt(i)['accept'] == 1 ? true : false;
        tmpItemSchudule.visit           = dbReturn.elementAt(i)['visit'] == 1 ? true : false;

        listSchudule.add(tmpItemSchudule);
      } // for(int i=0; i < dbReturn.length; i++){ ... }

      return listSchudule;
    }
    catch(error) {
      if(config.DEBUG){
        print('[SchuduleItemDAO][getDBSchudule] --------');
        print(error);
        print('[SchuduleItemDAO][getDBSchudule] --------');
      }
      return List<ItemSchudule>();
    }
  } // static Future<List<ItemSchudule>> getDB(BuildContext context) { ... }

  static Future<List<ItemSchudule>> getAllDB(BuildContext context) async {
    try {
      List<Map<String, dynamic>> dbReturn = await Provider.of<App>(context,listen: false).database.query(
        'schudule_item',
        distinct: true,
        orderBy: 'id_schudule asc, sequence asc',
      );

      List<ItemSchudule> listSchudule = List<ItemSchudule>();
      for(int i=0; i < dbReturn.length; i++){
        ItemSchudule tmpItemSchudule  = ItemSchudule();
        tmpItemSchudule.idItemSchudule  = dbReturn.elementAt(i)['id_schudule_item'];
        tmpItemSchudule.idSchudule      = dbReturn.elementAt(i)['id_schudule'];
        tmpItemSchudule.spot            = dbReturn.elementAt(i)['spot'];
        tmpItemSchudule.description     = dbReturn.elementAt(i)['description'];
        tmpItemSchudule.lastAlt         = dbReturn.elementAt(i)['last_alt'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(dbReturn.elementAt(i)['last_alt']);
        tmpItemSchudule.listImages      = List<ImgSchudule>();// await ImageDao.getAllDB(context);
        tmpItemSchudule.listQuestions   = Question();
        tmpItemSchudule.qtdeImages      = dbReturn.elementAt(i)['qtde_images'];
        tmpItemSchudule.sequence        = dbReturn.elementAt(i)['sequence'];
        tmpItemSchudule.accept          = dbReturn.elementAt(i)['accept'] == 1 ? true : false;
        tmpItemSchudule.visit           = dbReturn.elementAt(i)['visit'] == 1 ? true : false;

        listSchudule.add(tmpItemSchudule);
      } // for(int i=0; i < dbReturn.length; i++){ ... }

      return listSchudule;
    }
    catch(error) {
      if(config.DEBUG){
        print('[SchuduleItemDAO][getAllDB] --------');
        print(error);
        print('[SchuduleItemDAO][getAllDB] --------');
      }
      return List<ItemSchudule>();
    }
  } // static Future<List<ItemSchudule>> getAllDB(BuildContext context) { ... }

  static Future<bool> deleteDB(BuildContext context, ItemSchudule itemSchudule) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('schudule_item',
        where: 'id_schudule_item = ?',
        whereArgs: [
          itemSchudule.idItemSchudule,
        ],
      );

      //await ImageDao.deleteDB(context, itemSchudule);

      return true;
    }
    catch(error){
      if(config.DEBUG){
        print('[SchuduleItemDAO][deleteDB] ----------');
        print(error);
        print('[SchuduleItemDAO][deleteDB] ----------');
      } // if(config.DEBUG){ ... }
      return false;
    }
  } // static Future<bool> deleteDB(BuildContext context, Subsidiary subsidiary) { ... }

  static Future<bool> deleteSchuduleDB(BuildContext context, Schudule schudule) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('schudule_item',
        where: 'id_schudule = ?',
        whereArgs: [
          schudule.idSchudule,
        ],
      );

      /*for(int i=0; i < schudule.listItemSchudule.length; i++) {
        await ImageDao.deleteDB(context, schudule.listItemSchudule.elementAt(i));
      } // for(int i=0; i < schudule.listItemSchudule.length; i++) { ... }
      */

      return true;
    }
    catch(error){
      if(config.DEBUG){
        print('[SchuduleItemDAO][deleteSchuduleDB] ----------');
        print(error);
        print('[SchuduleItemDAO][deleteSchuduleDB] ----------');
      } // if(config.DEBUG){ ... }
      return false;
    }
  } // static Future<bool> deleteSchuduleDB(BuildContext context, Subsidiary subsidiary) { ... }

  static Future<bool> deleteAllDB(BuildContext context) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('schudule_item');

      //await ImageDao.deleteAllDB(context);

      return true;
    }
    catch(error){
      if(config.DEBUG){
        print('[SchuduleItemDAO][deleteAllDB] ----------');
        print(error);
        print('[SchuduleItemDAO][deleteAllDB] ----------');
      } // if(config.DEBUG){ ... }
      return false;
    }
  } // static Future<bool> deleteAllDB(BuildContext context, Subsidiary subsidiary) { ... }
} // class SchuduleItemDao { ... }