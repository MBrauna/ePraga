import 'package:epraga/allFiles.dart';

class SendJob extends ChangeNotifier {
  String nameProcedure, json, url;
  DateTime createdAt, updatedAt;

  SendJob({this.nameProcedure, this.json, this.url, this.createdAt, this.updatedAt});
} // class SendJob extends ChangeNotifier { ... }