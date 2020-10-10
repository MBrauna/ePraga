import 'package:epraga/allFiles.dart';

class Product extends ChangeNotifier {
  Product();

  int idProduct, idCategory;
  double quantity = 0, counter = 0;
  String description = 'Cadastro inválido', measure = 'ml';

  factory Product.fromJson(Map<String, dynamic> data) {
    Product produto     = Product();
    produto.idProduct   = data['id_product'];
    produto.idCategory  = data['id_category'];
    produto.quantity    = double.parse(data['quantity']);
    produto.description = data['description'];
    produto.measure     = data['measura'];

    return produto;
  } // factory Product.fromJson(Map<String, dynamic> data) { ... }
} // class Product extends ChangeNotifier { ... }