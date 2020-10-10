import 'package:epraga/allFiles.dart';
import 'package:epraga/config/config.dart' as config;

class Schudule extends ChangeNotifier {
  
  Schudule();

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  bool _status = false;
  DateTime _lastAlt = DateTime.now();
  int _idSchudule, _idSubsidiary;
  String _description = '';
  //Subsidiary _subsidiary;
  List<ItemSchudule> _listItemSchudule = List<ItemSchudule>();

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  bool get status                         =>  this._status ?? false;
  DateTime get lastAlt                    =>  this._lastAlt ?? DateTime.now();
  int get idSchudule                      =>  this._idSchudule;
  int get idSubsidiary                    =>  this._idSubsidiary;
  //Subsidiary get subsidiary               =>  this._subsidiary;
  String get description                  =>  this._description;
  List<ItemSchudule> get listItemSchudule =>  this._listItemSchudule;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set status(bool data){
    if(data == null) {
      this._status  = false;
    } // if(data == null) { ... }
    else {
      this._status  = data;
    } // else { ... }
    notifyListeners();
  } // set status(bool data){ ... }

  set lastAlt(DateTime data) {
    if(data == null) {
      this._lastAlt = DateTime.now();
    } // if(data == null) { ... }
    else {
      this._lastAlt = data;
    } // else { ... }
    notifyListeners();
  } // set lastAlt(DateTime data) { ... }

  set idSchudule(int data) {
    if(data == null || data <= 0) {
      this._idSchudule  = null;
    }
    else {
      this._idSchudule  = data;
    } // else { ... }
    notifyListeners();
  } // set idSchudule(int data) { ... }

  set idSubsidiary(int data) {
    if(data == null || data <= 0) {
      this._idSubsidiary  = null;
    } // if(data == null || data <= 0) { ... }
    else {
      this._idSubsidiary  = data;
    } // else { ... }
    notifyListeners();
  }

  set description(String data) {
    if(data == null || data.trim().isEmpty) {
      this._description = 'Nenhuma descrição cadastrada! Verifique.';
    } // if(data == null || data.trim().isEmpty) { ... }
    else {
      this._description = data;
    } // else { ... }
    notifyListeners();
  }

  /*set subsidiary(Subsidiary data) {
    if(data == null) {
      this._subsidiary  = null;
    } // if(data == null) { ... }
    else {
      this._subsidiary  = data;
    } // else { ... }
    notifyListeners();
  } // set subsidiary(Subsidiary data) { ... }
  */

  set listItemSchudule(List<ItemSchudule> data) {
    if(data == null || data.length <= 0) {
      this._listItemSchudule  = List<ItemSchudule>();
    } // if(data == null || data.length <= 0) { ... }
    else {
      this._listItemSchudule  = data;
    }
    notifyListeners();
  } // set listItemSchudule(List<ItemSchudule> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory Schudule.fromJson(Map<String, dynamic> data) {
    Schudule schudule = Schudule();
    List<ItemSchudule> itemSchudule = List<ItemSchudule>();
    try {
      if(data['itemSchudule'] != null) {
        data['itemSchudule'].forEach((element){
          itemSchudule.add(ItemSchudule.fromJson(element));
        }); // data['itemSchudule'].forEach((element){ ... });
      }

      schudule.idSchudule       = data['idSchudule'];
      schudule.idSubsidiary     = data['idSubsidiary'];
      schudule.description      = data['description'];
      schudule.status           = data['status'];
      //schudule.subsidiary       = Subsidiary.fromJson(data['subsidiary']);
      schudule.listItemSchudule = itemSchudule;
      schudule.lastAlt          = data['lastAlt'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(data['lastAlt']);
    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[Schudule][factory] -------');
        print(error);
        print('[Schudule][factory] -------');
      }
    } // catch(error) { ... }

    return schudule;
  } // factory Schudule.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //
} // class Schudule extends ChangeNotifier { ... }