import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import './../../util/fadePageRoute.dart';
import './../../../resources/allViews.dart';

class SplashController {
  Future<FadePageRoute> determinaLogin() async {
    try {
      SharedPreferences vPreferences = await SharedPreferences.getInstance();

      if (vPreferences.containsKey('dataLogin')) {
        if (vPreferences.getInt('dataLogin') <=
            DateTime.now().millisecondsSinceEpoch) {
          // Se ok envia para a tela principal
          return FadePageRoute(Login());
        } // if (value.getInt('dataLogin') <= DateTime.now().millisecondsSinceEpoch) { ... }
      } // if (value.containsKey('dataLogin')) { ...

      return FadePageRoute(Login());
    } // try { ... }
    catch (erro) {
      // Em caso de erro a saída é enviar a janela de login
      return FadePageRoute(Login());
    } // catch(erro) { ... }
  } // Future<MaterialPageRoute> determinaLogin() { ... }
}
