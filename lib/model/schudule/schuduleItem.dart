import 'package:epraga/allFiles.dart';

class SchuduleItem extends ChangeNotifier {
  
  int _id, _idSchudule, _sequence, _qtdeImage;
  num _latitude, _longitude;
  bool _visit, _combat, _accept, _status;
  String _note, _description;
  DateTime _lastAlt;
  List<ImageBase64> _images;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  SchuduleItem({int id, int idSchudule, int sequence, int qtdeImage, num latitude, num longitude, bool visit = false, bool combat = false, bool accept = false, bool status = true, String note, String description, DateTime lastAlt, List<ImageBase64> images}){
    this._id          = id;
    this._idSchudule  = idSchudule;
    this._sequence    = sequence;
    this._qtdeImage   = qtdeImage;
    this._latitude    = latitude;
    this._longitude   = longitude;
    this._visit       = visit;
    this._combat      = combat;
    this._accept      = accept;
    this._status      = status;
    this._note        = note;
    this._description = description;
    this._lastAlt     = lastAlt;
    
    if(images == null || images.length <= 0) {
      this._images  = List<ImageBase64>();
    } // if(images.length <= 0) { ... }
    else {
      this._images  = images;
    }
  } // SchuduleItem({int id, int idSchudule, int sequence, int qtdeImage, num latitude, num longitude, bool visit = false, bool combat = false, bool accept = false, bool status = true, String note, String description}){ ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  int get id => this._id;
  int get idSchudule => this._idSchudule;
  int get sequence => this._sequence;
  int get qtdeImage => this._qtdeImage;
  num get latitude => this._latitude;
  num get longitude => this._longitude;
  bool get visit => this._visit;
  bool get combat => this._combat;
  bool get accept => this._accept;
  bool get status => this._status;
  String get note => this._note;
  String get description => this._description;
  DateTime get lastAlt => this._lastAlt;
  List<ImageBase64> get images => this._images;

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  factory SchuduleItem.fromJson(Map<String, dynamic> data) {
    List<ImageBase64> contentImage  = List<ImageBase64>();

    if(data['images'] == null || data['images'].length <= 0) {
      contentImage  = List<ImageBase64>();
    } // if(data['images'] == null || data['images'].length <= 0) { ... }
    else {
      data['images'].forEach((element){
        ImageBase64 tmpImage  = ImageBase64.fromJson(element);
        contentImage.add(tmpImage);
      });
    } // else { ... }


    return SchuduleItem(
      id: data['id_schudule_item'],
      idSchudule: data['id_schudule'],
      description: data['description'],
      note: data['note'],
      visit: data['visit'],
      combat: data['pest_control'],
      sequence: data['sequence'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      qtdeImage: data['quantity_images'],
      lastAlt: data['last_alt_at'] == null ? DateTime.now() : DateTime.parse(data['last_alt_at']),
      accept: data['accept'],
      status: data['status'],
      images: contentImage,
    );
  } // factory SchuduleItem.fromJson(Map<String, dynamic> data) { ... }

  // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

  set accept(bool value){
    this._accept  = value;
    this._lastAlt = DateTime.now();
    notifyListeners();
  } // set accept(bool value){ ... }

  set note(String value) {
    this._note  = value;
    this._lastAlt = DateTime.now();
    notifyListeners();
  } // set note(String value) { ... }

  set latitude(num latitude) {
    this._latitude  = latitude;
    this._lastAlt = DateTime.now();
    notifyListeners();
  } // set latitude(num latitude) { ... }
  
  set longitude(num longitude) {
    this._longitude = longitude;
    this._lastAlt = DateTime.now();
    notifyListeners();
  } // set longitude(num longitude) { ... }

  set images(List<ImageBase64> data) {
    if(data == null || data.length <= 0) {
      this._images  = List<ImageBase64>();
    } // if(data == null || data.length <= 0) { ... }
    else {
      this._images  = data;
    } // else { ... }
    this._lastAlt = DateTime.now();
    notifyListeners();
  } // set images(List<ImageBase64> data) { ... }

} // class SchuduleItem extends StatelessElement { ... }