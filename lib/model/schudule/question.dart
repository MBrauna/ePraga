import 'package:epraga/allFiles.dart';

class Question extends ChangeNotifier {

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  /*int _idQuestion,  _idItemSchudule, _idOption;
  String _description;
  bool _listProduct, _listPrague;
  List<Option> _listOptions;*/

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  Question();
  /*
  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int get idQuestion          =>  this._idQuestion;
  int get idItemSchudule      =>  this._idItemSchudule;
  int get idOption            =>  this._idOption;
  String get description      =>  this._description.trim();
  bool get listProduct        =>  this._listProduct ?? false;
  bool get listPrague         =>  this._listPrague ?? false;
  List<Option> get listOption =>  this._listOptions ?? List<Option>();

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set idQuestion(int data) {
    if(data == null || data <= 0) {
      this._idQuestion  = null;
    } // if(data == null || data <= 0) { ... }
    else {
      this._idQuestion  = data;
    }
    notifyListeners();
  }

  set idItemSchudule(int data) {
    if(data == null || data <= 0) {
      this._idItemSchudule  = null;
    } // if(data == null || data <= 0) { ... }
    else {
      this._idItemSchudule  = data;
    }
    notifyListeners();
  }

  set idOption(int data) {
    if(data == null || data <= 0) {
      this._idItemSchudule  = null;
    } // if(data == null || data <= 0) { ... }
    else {
      this._idItemSchudule  = data;
    }
    notifyListeners();
  }

  set description(String data) {
    if(data == null || data.trim().isEmpty) {
      this._description = 'Nenhuma descrição informada!';
    }
    else {
      this._description = data.trim();
    }
    notifyListeners();
  }

  set listProduct(bool data) {
    if(data == null) {
      this._listProduct = false;
    }
    else {
      this._listProduct = data ?? false;
    }
    notifyListeners();
  }

  set listPrague(bool data) {
    if(data == null) {
      this._listPrague = false;
    }
    else {
      this._listPrague = data ?? false;
    }
    notifyListeners();
  }

  set listOption(List<Option> data) {
    if(data == null) {
      this._listOptions = List<Option>();
    }
    else {
      this._listOptions = data;
    }
    notifyListeners();
  }

  factory Question.fromJson(Map<String, dynamic> data){
    Question question = Question();

    try {
      question.description  = data['description'];
      question.idItemSchudule = data['idItemSchudule'];
      question.idOption       = data['idOption'];
      question.listPrague     = data['prague'];
      question.listProduct    = data['product'];
      List<Option> optList    = List<Option>();

      data['listOption'].forEach((itemOption) {
        optList.add(Option.fromJson(itemOption));
      });

      question.listOption     = optList;
    } // try { ... }
    catch(error) {
      print('[Question][factory] -------');
      print(error);
      print('[Question][factory] -------');
    } // catch(error) { ... }

    return question;
  } // Question.fromJson(Map<String, dynamic> data){ ... }
  */

  List<Product> listVisit = List<Product>();
  List<Product> listProd  = List<Product>();
  List<int> sitIsca       = List<int>();
  List<int> naoConform    = List<int>();
  List<Map<String, dynamic>> listIsca  = [
    {'description' : 'Consumida', 'id' : 1},
    {'description' : 'Não consumida', 'id' : 2},
    {'description' : 'Mofo/Fungo', 'id' : 3},
    {'description' : 'Removida/Intempérie', 'id' : 4},
    {'description' : 'Removida não identificado', 'id' : 5},
  ];
  List<Map<String, dynamic>> listConform  = [
    {'description' : 'Limpeza', 'id' : 1},
    {'description' : 'Manutenção da área', 'id' : 2},
    {'description' : 'Acúmulo de objetos não conformes', 'id' : 3},
    {'description' : 'Insetos', 'id' : 4},
    {'description' : 'Toca de ratos', 'id' : 5},
  ];
  int iscaSubstituida     = 0;
  int ambienteAdequado    = 0;
} // class Question extends ChangeNotifier { ... }