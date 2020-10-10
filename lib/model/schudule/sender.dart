import 'package:epraga/allFiles.dart';

class Sender extends ChangeNotifier{
  int id = DateTime.now().millisecondsSinceEpoch;
  bool status = true;
  String content, url;

  Sender();
}