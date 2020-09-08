import 'package:camera/camera.dart';
import 'package:epraga/allFiles.dart';

class EPraga extends ChangeNotifier {
  Database database;
  Login login;
  DateTime accessDate;
  List<CameraDescription> cameras;
} // class EPraga extends ChangeNotifier { ... }