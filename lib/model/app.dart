import 'package:epraga/allFiles.dart';
import 'package:sqflite/sqflite.dart';
import 'package:camera/camera.dart';

class App extends ChangeNotifier {
  Database database;
  List<CameraDescription> cameraList;
  Login login;
  List<Schudule> listSchudule = List<Schudule>();
  List<Subsidiary> listSubsidiary = List<Subsidiary>();
  List<Product> listProducts = List<Product>();
  List<Sender> listSender = List<Sender>();
} // class App extends ChangeNotifier { ... }