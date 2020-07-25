class Prague {
  int _id;
  String  _description;
  List<int> _idCombat;
  List<int> _idEquipment;

  /// [GETTERS] - Coleta informações de pragas
  int get id => this._id;
  String get description => this._description;
  List<int> get idCombat => this._idCombat;
  List<int> get idEquipment => this._idEquipment;

  /// [CONSTRUCTORS] - Método construtor para informações
  Prague(int id, String description, {List<int> idCombat, List<int> equipment}) {
    this._id          = id;
    this._description = description;
    this._idCombat    = idCombat;
    this._idEquipment = equipment;
  } // Prague(int id, String description, {List<int> idCombat, List<int> equipment}) { ... }

  factory Prague.fromJson(Map<String, dynamic> json) {
    Prague vRetorno;
    vRetorno._id  = json['ID'];
    vRetorno._description = json['description'];

    vRetorno._idCombat.clear();
    json['idCombat'].forEach((element) {
      vRetorno._idCombat.add(element);
    }); // json['idCombat'].forEach((element) { ... }

    vRetorno._idEquipment.clear();
    json['idEquipment'].forEach((element) {
      vRetorno._idEquipment.add(element);
    }); // json['idCombat'].forEach((element) { ... }

    return vRetorno;
  } // factory Prague.fromJson(Map<String, dynamic> json) { ... }
} // class Prague { ... }