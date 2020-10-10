import 'dart:convert';

import 'package:epraga/allFiles.dart';
import 'package:epraga/config/config.dart' as config;
import 'package:http/http.dart' as http;

class SchuduleController {

  static Future requestSchudule(BuildContext context) async {
    try {
      bool network  = await VerifyNetwork().verify();

      if(!network) {
        Message(context).info('Você está operando offline! Os dados exibidos foram armazenados anteriormente.',tempo: 3);
        bool execute  = await DataController.getData(context, ['subsidiary','schudule']);
        if(!execute){
          Message(context).error('Erro ao obter os dados! Verifique.',tempo: 3);
        }

      }
      else {
        // Se tem rede, então primeiramente procura na rede
        // Monta os headers da requisição
        Map<String, String> headers  = Map<String, String>();
        headers.putIfAbsent('accept',       () => 'application/json');
        headers.putIfAbsent('Authorization',() => 'Bearer ' + Provider.of<App>(context, listen: false).login.hash);

        final response  = await http.post(
          config.ENDPOINT_SCHUDULE,
          headers: headers,
        );

        Map<String, dynamic> dataResponse = jsonDecode(response.body);

        switch(response.statusCode) {
          case 200:
            List<Schudule> listSchudule = List<Schudule>();
            dataResponse['schudule'].forEach((element){
              Schudule schudule = Schudule.fromJson(element);
              listSchudule.add(schudule);
            }); // dataResponse['schudule'].forEach((element){ ... });

            List<Subsidiary> listSubsidiary = List<Subsidiary>();
            dataResponse['subsidiary'].forEach((element){
              Subsidiary subsidiary = Subsidiary.fromJson(element);
              listSubsidiary.add(subsidiary);
            }); // dataResponse['subsidiary'].forEach((element){ ... });

            List<Product> listProducts  = List<Product>();
            dataResponse['products'].forEach((element){
              Product product = Product.fromJson(element);
              listProducts.add(product);
            });

            Provider.of<App>(context, listen: false).listSchudule   = listSchudule;
            Provider.of<App>(context, listen: false).listSubsidiary = listSubsidiary;
            Provider.of<App>(context, listen: false).listProducts   = listProducts;

            // Executa o comando para salvar os dados ...
            bool execute  = await DataController.setData(context, ['subsidiary','schudule','products']);
            if(execute){
              Message(context).info('Dados obtidos da internet e salvos!',tempo: 1);
            }
            else {
              Message(context).error('Erro ao armazenar os dados! Verifique.',tempo: 3);
            }
            execute = await DataController.getData(context, ['subsidiary','schudule','products']);
            break;
          case 401:
            LoginDao.deleteAllDB(context);
            Navigator.of(context).pushReplacement(FadePageRoute(LoginPage(message: 'Sua sessão expirou!',)));
            break;
          default:
            Message(context).error(dataResponse['error']['message'],tempo: 5);
            break;
        } // switch(response.statusCode) { ... }
      }
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[SchuduleControler][requestSchudule] --------');
        print(error);
        print('[SchuduleControler][requestSchudule] --------');
      } // if(config.DEBUG) { ... }
    } // catch(error) { ... }
  } // static Future requestSchudule(BuildContext context) { .. }
}