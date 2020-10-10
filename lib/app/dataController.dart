import 'package:epraga/allFiles.dart';
import 'package:epraga/config/config.dart' as config;

class DataController {
  static Future<bool> setLogin(BuildContext context, Login login) async {
    try {
      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

      // Limpa os dados da tabela
      LoginDao.deleteAllDB(context);
      // Salva no banco os dados
      LoginDao.setDB(context, login);
      // Salva na sessão
      Provider.of<App>(context, listen: false).login  = login;

      return true;

      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[DataController][setLogin] -----');
        print(error);
        print('[DataController][setLogin] -----');
      } // if(config.DEBUG) { ... }

      return false;
    } // catch(error) { ... }
  } // static Future<bool> setData(BuildContext context, List<String> modules) async { ... }

  static Future<bool> getLogin(BuildContext context) async {
    try {
      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
      List<Login> listLogin = await LoginDao.getDB(context);
      Provider.of<App>(context).login = listLogin.first;

      return true;

      // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[DataController][getLogin] -----');
        print(error);
        print('[DataController][getLogin] -----');
      } // if(config.DEBUG) { ... }

      return false;
    } // catch(error) { ... }
  } // static Future<bool> setData(BuildContext context, List<String> modules) async { ... }








  static Future<bool> setData(BuildContext context, List<String> modules) async {
    try {
      if(modules.contains('subsidiary')) {
        // Percorre a lista de subsidiary procurando por alterações
        for(int i = 0; i<Provider.of<App>(context, listen: false).listSubsidiary.length; i++) {
          await SubsidiaryDao.setData(context, Provider.of<App>(context, listen: false).listSubsidiary.elementAt(i));
        } // for(int i = 0; i<Provider.of<App>(context).listSubsidiary.length; i++) { ... }
      } // if(modules.contains('subsidiary')) { ... }

      if(modules.contains('schudule')) {
        // Percorre a lista de schudules procurando alterações
        for(int i = 0; i<Provider.of<App>(context, listen: false).listSchudule.length; i++) {
          await SchuduleDao.setData(context, Provider.of<App>(context, listen: false).listSchudule.elementAt(i));

          // Para cada agendamento vamos obter os itens agendados
          for(int j =0; j < Provider.of<App>(context, listen: false).listSchudule.elementAt(i).listItemSchudule.length; j++) {
            await SchuduleItemDao.setDB(context, Provider.of<App>(context, listen: false).listSchudule.elementAt(i).listItemSchudule.elementAt(j));

            for(int k=0; k < Provider.of<App>(context, listen: false).listSchudule.elementAt(i).listItemSchudule.elementAt(j).listImages.length; k++) {
              await ImageDao.setDB(context, Provider.of<App>(context, listen: false).listSchudule.elementAt(i).listItemSchudule.elementAt(j).listImages.elementAt(k));
            } // for(int k=0; k < Provider.of<App>(context, listen: false).listSchudule.elementAt(i).listItemSchudule.elementAt(j).listImages.length; k++) { ... }
          } // for(int j =0; j < Provider.of<App>(context, listen: false).listSchudule.elementAt(i).listItemSchudule.length; j++) { ... }
        } // for(int i = 0; i<Provider.of<App>(context, listen: false).listSchudule.length; i++) { ... }
      } // if(modules.contains('schudule')) { ... }

      if(modules.contains('products')) {
        await ProductDao.deleteAllDB(context);
        for(int i=0; i<Provider.of<App>(context, listen: false).listProducts.length; i++) {
          await ProductDao.setDB(context, Provider.of<App>(context, listen: false).listProducts.elementAt(i));
        } // for(int i=0; i<Provider.of<App>(context, listen: false).listProducts.length; i++) { ... }
      } // if(modules.contains('products')) { ... }

      return true;
    }
    catch(error) {
      if(config.DEBUG) {
        print('[DataController][setData] -----------------');
        print(error);
        print('[DataController][setData] -----------------');
      }
      return false;
    }
  } // static Future<bool> setData(BuildContext context, List<String> modules) async { ... }


  static Future<bool> getData(BuildContext context, List<String> modules) async {
    try {
      if(modules.contains('subsidiary')) {
        Provider.of<App>(context, listen: false).listSubsidiary  = await SubsidiaryDao.getAllDB(context);
      } // if(modules.contains('subsidiary')) { ... }

      if(modules.contains('schudule')) {
        Provider.of<App>(context, listen: false).listSchudule    = await SchuduleDao.getAllDB(context);

        List<ImgSchudule> image = await ImageDao.getAllDB(context);

        // Para cada agendamento vamos obter os itens agendados
        for(int i =0; i < Provider.of<App>(context, listen: false).listSchudule.length; i++) {
          Provider.of<App>(context,listen: false).listSchudule.elementAt(i).listItemSchudule  = await SchuduleItemDao.getDBSchudule(context, Provider.of<App>(context,listen: false).listSchudule.elementAt(i).idSchudule);

          for(int j=0; j < Provider.of<App>(context, listen: false).listSchudule.elementAt(i).listItemSchudule.length; j++) {
            Provider.of<App>(context, listen: false).listSchudule.elementAt(i).listItemSchudule.elementAt(j).listImages               = await ImageDao.getDB(context, Provider.of<App>(context, listen: false).listSchudule.elementAt(i).listItemSchudule.elementAt(j).idItemSchudule);
            Provider.of<App>(context, listen: false).listSchudule.elementAt(i).listItemSchudule.elementAt(j).listQuestions            = Question();
            Provider.of<App>(context, listen: false).listSchudule.elementAt(i).listItemSchudule.elementAt(j).listQuestions.listProd   = Provider.of<App>(context, listen: false).listProducts;
            Provider.of<App>(context, listen: false).listSchudule.elementAt(i).listItemSchudule.elementAt(j).listQuestions.listVisit  = Provider.of<App>(context, listen: false).listProducts;
          } // for(int j=0; j < Provider.of<App>(context, listen: false).listSchudule.elementAt(i).listItemSchudule.length; j++) { ... }
        } // for(int i =0; i < Provider.of<App>(context, listen: false).listSchudule.length; i++) { ... }
      } // if(modules.contains('schudule')) { ... }

      if(modules.contains('products')) {
        Provider.of<App>(context, listen: false).listProducts = await ProductDao.getDB(context);
      }

      return true;
    }
    catch(error){
      if(config.DEBUG) {
        print('[DataController][getData] -----------------');
        print(error);
        print('[DataController][getData] -----------------');
      }
      return false;
    }
  } // static Future<bool> getData(BuildContext context, List<String> modules) async { ... }

} // class DataController { ... }