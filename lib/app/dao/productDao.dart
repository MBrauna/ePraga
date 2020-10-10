import 'package:epraga/allFiles.dart';
import 'package:epraga/config/config.dart' as config;

class ProductDao {
  static Future<bool> setDB(BuildContext context, Product product) async {
    try {
      List<Product> listProd  = await ProductDao.getDB(context);

      for(int i=0; i<listProd.length; i++) {
        if(listProd.elementAt(i).idProduct  ==  product.idProduct) {
          await ProductDao.deleteDB(context, product.idProduct);
        } // if(element.idProduct  ==  product.idProduct) { ... }
      }

      await Provider.of<App>(context, listen: false).database.insert('product',{
        'id_product'  : product.idProduct,
        'id_category' : product.idCategory,
        'quantity'    : product.quantity,
        'description' : product.description,
        'measure'     : product.measure,
      }); // Provider.of<App>(context).database.insert('login',{ ...});

      return true;
    }
    catch(error) {
      if(config.DEBUG){
        print('[ProductDao][setDB] --------------');
        print(error);
        print('[ProductDao][setDB] --------------');
      } // if(config.DEBUG){ ... }
      return false;
    }
  } // static Future<bool> setDB(BuildContext context, Product product) async { ... }

  static Future<List<Product>> getDB(BuildContext context) async {
    try {
      List<Product> dataReturn  = List<Product>();

      List<Map<String, dynamic>> dbReturn = await Provider.of<App>(context,listen: false).database.query(
        'product',
        distinct: true,
        orderBy: 'id_product'
      );

      dbReturn.forEach((element) {
        Product produto     = Product();
        produto.idProduct   = element['id_product'];
        produto.idCategory  = element['id_category'];
        produto.quantity    = element['quantity'];
        produto.description = element['description'];
        produto.measure     = element['measure'];

        dataReturn.add(produto);
      });

      return dataReturn;
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[LoginDao][getDB] -----');
        print(error);
        print('[LoginDao][getDB] -----');
      }
      return List<Product>();
    } // catch(error) { ... }
  } // static Future<List<Product>> getDB(BuildContext context) async { ... }

  static Future<bool> deleteDB(BuildContext context, int idProduct) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('product',
        where: 'id_product = ?',
        whereArgs: [
          idProduct,
        ],
      );

      return true;
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[ProductDao][deleteDB] -----');
        print(error);
        print('[ProductDao][deleteDB] -----');
      }

      return false;
    } // catch(error) { ... }
  } // static Future<bool> deleteDB(BuildContext context) async { ... }

  static Future<bool> deleteAllDB(BuildContext context) async {
    try {
      await Provider.of<App>(context,listen: false).database.delete('product');

      return true;
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[ProductDao][deleteAllDB] -----');
        print(error);
        print('[ProductDao][deleteAllDB] -----');
      }

      return false;
    } // catch(error) { ... }
  }
}