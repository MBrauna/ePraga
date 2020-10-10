import 'dart:io';

import 'package:camera/camera.dart';
import 'package:device_info/device_info.dart';
import 'package:epraga/allFiles.dart';
import 'package:epraga/config/config.dart' as config;
import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';

class SplashController {
  static Future<bool> permissions() async {
    final PermissionHandler permission = PermissionHandler();

    var result = await permission.requestPermissions([
      PermissionGroup.camera,
      PermissionGroup.location,
      PermissionGroup.locationAlways,
      PermissionGroup.locationWhenInUse,
      PermissionGroup.storage,
      PermissionGroup.phone,
    ]);

    if((result[PermissionGroup.camera] != PermissionStatus.granted)){
      await permission.requestPermissions([
        PermissionGroup.camera,
      ]);
    } // if((result[PermissionGroup.camera] != PermissionStatus.granted)){ ... }

    if((result[PermissionGroup.location] != PermissionStatus.granted)){
      await permission.requestPermissions([
        PermissionGroup.location,
      ]);
    } // if((result[PermissionGroup.location] != PermissionStatus.granted)){ ... }

    if((result[PermissionGroup.locationAlways] != PermissionStatus.granted)){
      await permission.requestPermissions([
        PermissionGroup.locationAlways,
      ]);
    } // if((result[PermissionGroup.locationAlways] != PermissionStatus.granted)){ ... }

    if((result[PermissionGroup.locationWhenInUse] != PermissionStatus.granted)){
      await permission.requestPermissions([
        PermissionGroup.locationWhenInUse,
      ]);
    } // if((result[PermissionGroup.locationWhenInUse] != PermissionStatus.granted)){ ... }

    if((result[PermissionGroup.storage] != PermissionStatus.granted)){
      await permission.requestPermissions([
        PermissionGroup.storage,
      ]);
    } // if((result[PermissionGroup.storage] != PermissionStatus.granted)){ ... }

    if((result[PermissionGroup.phone] != PermissionStatus.granted)){
      await permission.requestPermissions([
        PermissionGroup.phone,
      ]);
    } // if((result[PermissionGroup.phone] != PermissionStatus.granted)){ ... }

    result = await permission.requestPermissions([
      PermissionGroup.camera,
      PermissionGroup.location,
      PermissionGroup.locationAlways,
      PermissionGroup.locationWhenInUse,
      PermissionGroup.storage,
      PermissionGroup.phone,
    ]);

    if((result[PermissionGroup.camera] != PermissionStatus.granted) ||
      (result[PermissionGroup.location] != PermissionStatus.granted) ||
      (result[PermissionGroup.locationAlways] != PermissionStatus.granted) ||
      (result[PermissionGroup.locationWhenInUse] != PermissionStatus.granted) ||
      (result[PermissionGroup.storage] != PermissionStatus.granted) ||
      (result[PermissionGroup.phone] != PermissionStatus.granted)) {
      return false;
    } // if((result[PermissionGroup.camera] != PermissionStatus.granted) || (result[PermissionGroup.location] != PermissionStatus.granted) || (result[PermissionGroup.locationAlways] != PermissionStatus.granted) || (result[PermissionGroup.locationWhenInUse] != PermissionStatus.granted) || (result[PermissionGroup.mediaLibrary] != PermissionStatus.granted) || (result[PermissionGroup.photos] != PermissionStatus.granted) ||  (result[PermissionGroup.storage] != PermissionStatus.granted)) { ... }

    return true;
  } // static Future<bool> permissions() async { ... }

  static Future getRoute(BuildContext context) async {
    try {
      Map<String, dynamic> plataforma         = Map<String, dynamic>();
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

      // Inicializa o banco de dados na aplicação
      Provider.of<App>(context, listen: false).database = await EpragaDB.createDatabase();

      // Inicializa as câmeras ePraga
      WidgetsFlutterBinding.ensureInitialized();
      Provider.of<App>(context, listen: false).cameraList = await availableCameras();
      Provider.of<Mobile>(context, listen: false).imei    = await ImeiPlugin.getImeiMulti(shouldShowRequestPermissionRationale: true);

      if(Platform.isAndroid) {
        final build = await deviceInfoPlugin.androidInfo;

        // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

        // Coleta a versão
        Map<String, dynamic> versao = Map<String, dynamic>();
        versao.putIfAbsent('securityPatch', () => build.version.securityPatch);
        versao.putIfAbsent('sdkInt', () => build.version.sdkInt);
        versao.putIfAbsent('release', () => build.version.release);
        versao.putIfAbsent('previewSdkInt', () => build.version.previewSdkInt);
        versao.putIfAbsent('incremental', () => build.version.incremental);
        versao.putIfAbsent('codename', () => build.version.codename);
        versao.putIfAbsent('baseOS', () => build.version.baseOS);

        plataforma.putIfAbsent('version', () => versao);

        // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

        plataforma.putIfAbsent('dispositivo', () => 'Android');

        plataforma.putIfAbsent('androidId', () => build.androidId);
        plataforma.putIfAbsent('board', () => build.board);
        plataforma.putIfAbsent('bootloader', () => build.bootloader);
        plataforma.putIfAbsent('brand', () => build.brand);
        plataforma.putIfAbsent('device', () => build.device);
        plataforma.putIfAbsent('display', () => build.display);
        plataforma.putIfAbsent('fingerprint', () => build.fingerprint);
        plataforma.putIfAbsent('hardware', () => build.hardware);
        plataforma.putIfAbsent('host', () => build.host);
        plataforma.putIfAbsent('id', () => build.id);
        plataforma.putIfAbsent('isPhysicalDevice', () => build.isPhysicalDevice);
        plataforma.putIfAbsent('manufacturer', () => build.manufacturer);
        plataforma.putIfAbsent('model', () => build.model);
        plataforma.putIfAbsent('product', () => build.product);
        plataforma.putIfAbsent('supported32BitAbis', () => build.supported32BitAbis);
        plataforma.putIfAbsent('supported64BitAbis', () => build.supported64BitAbis);
        plataforma.putIfAbsent('supportedAbis', () => build.supportedAbis);
        plataforma.putIfAbsent('systemFeatures', () => build.systemFeatures);
        plataforma.putIfAbsent('tags', () => build.tags);
        plataforma.putIfAbsent('type', () => build.type);

        Provider.of<Mobile>(context, listen: false).platform= plataforma;
      } // if(Platform.isAndroid) { ... }
      else if(Platform.isIOS) {
        final build = await deviceInfoPlugin.iosInfo;

        // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

        // Coleta a versão
        Map<String, dynamic> versao = Map<String, dynamic>();
        versao.putIfAbsent('machine', () => build.utsname.machine);
        versao.putIfAbsent('nodename', () => build.utsname.nodename);
        versao.putIfAbsent('release', () => build.utsname.release);
        versao.putIfAbsent('sysname', () => build.utsname.sysname);
        versao.putIfAbsent('vesion', () => build.utsname.version);

        plataforma.putIfAbsent('utsname', () => versao);

        // -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- # -- //

        plataforma.putIfAbsent('dispositivo', () => 'IOS');

        plataforma.putIfAbsent('identifierForVendor', () => build.identifierForVendor);
        plataforma.putIfAbsent('isPhysicalDevice', () => build.isPhysicalDevice);
        plataforma.putIfAbsent('localizedModel', () => build.localizedModel);
        plataforma.putIfAbsent('model', () => build.model);
        plataforma.putIfAbsent('name', () => build.name);
        plataforma.putIfAbsent('systemName', () => build.systemName);
        plataforma.putIfAbsent('systemVersion', () => build.systemVersion);

        Provider.of<Mobile>(context, listen: false).platform= plataforma;
      } // if(Platform.isIOS) { ... }
      else {
        SystemNavigator.pop();
        return;
      } // else { ... }

      // List - Coleta os dados do Login do database
      List<Login> login = await LoginDao.getDB(context);
      if(login.length <= 0 || login.length > 1) {
        login.forEach((element) {
          LoginDao.deleteDB(context, element);
        }); // login.forEach((element) { ... });

        Navigator.pushReplacement(context, FadePageRoute(LoginPage()));
        return;
      } // if(login.length <= 0) { ... }
      else {
        // Acessa a página principal.
        Provider.of<App>(context, listen: false).login      = login.first;
        Navigator.pushReplacement(context, FadePageRoute(MainPage()));
        return;
      } // else { ... }

    } // try { ... }
    catch(error) {
      if(config.DEBUG) {
        print('[SplashController][getRoute] ------------>');
        print(error);
        print('[SplashController][getRoute] ------------>');
      } // if(config.DEBUG) { ... }
    } // catch(error) { ... }
  } // static Future getRoute(BuildContext context) async { ... }aQ ASQ
} // class SplashController { ... }