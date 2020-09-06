import 'package:epraga/allFiles.dart';

class Schudule extends ChangeNotifier {

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  bool _status;
  DateTime _lastAlt, _startDate, _endDate, _createdAt, _updatedAt;
  int _id, _idSubsidiary, _idResponsible;
  String _description;
  List<SchuduleItem> _schuduleItem;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  Schudule({int id, String description, int idSubsidiary, int idResponsible, DateTime lastAlt, DateTime startDate, DateTime endDate, bool status = false,DateTime createdAt,DateTime updatedAt, List<SchuduleItem> schuduleItem}) {
    this._id  = id;
    this._description = description;
    this._idSubsidiary  = idSubsidiary;
    this._idResponsible = idResponsible;

    if(lastAlt == null) {
      this._lastAlt = DateTime.now();
    } // if(lastAlt == null) { ... }
    else {
      this._lastAlt = lastAlt;
    } // else { ... }

    if(startDate == null) {
      this._startDate = DateTime.now();
    } // if(startDate == null) { ... }
    else {
      this._startDate = startDate;
    } // else { ... }

    this._endDate = endDate;
    this._status  = status;

    if(createdAt == null) {
      this._createdAt = DateTime.now();
    } // if(startDate == null) { ... }
    else {
      this._createdAt = createdAt;
    } // else { ... }

    if(updatedAt == null) {
      this._updatedAt = DateTime.now();
    } // if(startDate == null) { ... }
    else {
      this._updatedAt = updatedAt;
    } // else { ... }

    if(schuduleItem.length <= 0) {
      this._schuduleItem  = List<SchuduleItem>();
    } // if(schuduleItem.length <= 0) { ... }
    else {
      this._schuduleItem  = schuduleItem;
    } // else { ... }
  } // Schudule({int id, String description, int idSubsidiary, int idResponsible, DateTime lastAlt, DateTime startDate, DateTime endDate, bool status,DateTime createdAt,DateTime updatedAt,}) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int get id => this._id;
  String get description => this._description;
  int get idSubsidiary => this._idSubsidiary;
  int get idResponsible => this._idResponsible;
  DateTime get lastAlt => this._lastAlt;
  DateTime get startDate => this._startDate;
  DateTime get endDate => this._endDate;
  bool get status => this._status;
  DateTime get createdAt => this._createdAt;
  DateTime get updatedAt => this._updatedAt;
  List<SchuduleItem> get schuduleItem => this._schuduleItem;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set schuduleItem(List<SchuduleItem> data) {
    if(data.length <= 0) {
      this._schuduleItem  = List<SchuduleItem>();
    } // if(data.length <= 0) { ... }
    else {
      this._schuduleItem  = data;
    } // else { ... }
    this._lastAlt       = DateTime.now();
    notifyListeners();
  } // set schuduleItem(List<SchuduleItem> data) { ... }

  set endDate(DateTime date) {
    if(date == null) {
      this._endDate = DateTime.now();
    } // if(date == null) { ... }
    else {
      this._endDate = date;
    } // else { ... }
    this._status    = false;
    this._lastAlt   = DateTime.now();
    this._updatedAt = DateTime.now();
    notifyListeners();
  } // set endDate(DateTime date) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory Schudule.fromJson(Map<String, dynamic> data) {
    List<SchuduleItem> schuduleItem = List<SchuduleItem>();

    if(data['item'] != null || data['item'].length > 0) {
      data['item'].forEach((element){
        SchuduleItem tmpData  = SchuduleItem.fromJson(element);
        schuduleItem.add(tmpData);
      });
    } // if(data['item'] != null || data['item'].length > 0) { ... }


    return Schudule(
      id: data['id_schudule'],
      description: data['description'],
      idSubsidiary: data['id_subsidiary'],
      lastAlt: data['last_alt_at'] == null ? DateTime.now() : DateTime.parse(data['last_alt_at']),
      startDate: data['start_date'] == null ? DateTime.now() : DateTime.parse(data['start_date']),
      endDate: data['start_date'] == null ? DateTime.now() : DateTime.parse(data['start_date']),
      status: data['status'],
      createdAt: data['created_at'] == null ? DateTime.now() : DateTime.parse(data['created_at']),
      updatedAt: data['updated_at'] == null ? DateTime.now() : DateTime.parse(data['updated_at']),
      idResponsible: data['id_responsible'],
      schuduleItem: schuduleItem,
    );
  } // factory Schudule.fromJson(Map<String, dynamic> date) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

} // class Schudule extends ChangeNotifier { ... }