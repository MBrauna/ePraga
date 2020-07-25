class Location {
  int _id;
  String _description;
  Map<String, dynamic> _coordinates;

  /// [GETTERS] - Coleta o conteúdo para retorno
  int get id => this._id;
  String get description => this._description;
  Map<String, dynamic> get coordinates => this._coordinates;

  Location(int id, String description, Map<String, dynamic> coordinates) {
    this._id = id;
    this._description = description;
    this._coordinates = coordinates;
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    Location vReturn;
    vReturn._id = json['ID'];
    vReturn._description = json['description'];
    vReturn._coordinates = json['coordinates'];

    return vReturn;
  } // factory Location.fromJson(Map<String, dynamic> json) { ... }
} // class Location { ... }
