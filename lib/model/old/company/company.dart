import './../location/location.dart';

class Company {
  int _id;
  String _description;
  String _initials;
  List<Location> _locations;

  /// [GETTERS] - Coleta os dados para retorno
  int get id => this._id;
  String get description => this._description;
  String get initials => this._initials;
  String get completeDescription => '[' + this._initials + '] - ' + this._description;
  List<Location> get locations => this._locations;

  /// [CONSTRUCTOR] - Método construtor para Companies
  Company(int id, String description, {String initials = '***', List<Location> locations}) {
    this._id  = id;
    this._description = description;
    this._initials  = initials;
    this._locations = locations;
  } // Company(int id, String description, {String initials = '***', List<Location> locations}) { ... }

  factory Company.fromJson(Map<String, dynamic> json) {
    Company vReturn;
    vReturn._id  = json['ID'];
    vReturn._description = json['description'];
    vReturn._initials  = json['initials'];

    vReturn._locations.clear();
    json['location'].forEach((element) {
      vReturn._locations.add(Location.fromJson(element));
    });

    return vReturn;
  } // factory Company.fromJson(Map<String, dynamic> json) { ... }
} // class Company { ... }