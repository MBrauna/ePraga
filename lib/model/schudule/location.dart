import 'package:epraga/allFiles.dart';

class Location extends ChangeNotifier {
  String _address;
  num _latitude, _longitude;
  int _id;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  Location();

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int get id => this._id;
  num get latitude => this._latitude;
  num get longitude =>  this._longitude;
  String get address => this._address;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory Location.fromJson(Map<String, dynamic> data) {
    Location dataReturn   = Location();

    try {
      dataReturn.id         = data['id_location'];
      dataReturn.latitude   = data['latitude'];
      dataReturn.longitude  = data['longitude'];
      dataReturn.address    = data['address'];
    } // try { ... }
    catch(error) {
      print('[Location][factory] ---------');
      print(error);
      print('[Location][factory] ---------');
    } // catch(error) { ... }

    return dataReturn;
  } // factory Location.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set id(int data) {
    if(data == null || data <= 0) {
      this._id  = null;
    } // if(data == null || data <= 0) { ... }
    else {
      this._id  = data;
    } // else { ... }
    notifyListeners();
  } // set id(int data) { ... }

  set latitude(num data) {
    if(data == null) {
      this._latitude = 0;
    } // if(data == null) { ... }
    else {
      this._latitude  = data;
    } // else { ... }
    notifyListeners();
  } // set latitude(num data) { ... }

  set longitude(num data) {
    if(data == null) {
      this._longitude = 0;
    } // if(data == null) { ... }
    else {
      this._longitude = data;
    } // else { ... }
    notifyListeners();
  } // set longitude(num data) { ... }

  set address(String data) {
    if(data == null || data.trim().isEmpty) {
      this._address = 'Nenhum endereço informado';
    } // if(data == null || data.trim().isEmpty) { ... }
    else {
      this._address = data.trim();
    } // else { ... }
    notifyListeners();
  } // set address(String data) { ... }
} // class Location extends ChangeNotifier { ... }