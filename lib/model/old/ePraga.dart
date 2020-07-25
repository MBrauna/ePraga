import 'package:flutter/foundation.dart';

import './login/login.dart';
import './prague/prague.dart';
import './company/company.dart';

class EPraga extends ChangeNotifier with DiagnosticableTreeMixin {
  Login _login;
  List<Prague> _listPrague;
  List<Company> _listCompany;
  //List<Schedule>  _listSchedule;

  /// [GETTERS] - retorna os dados armazenados
  Login get login => this._login;
  List<Prague> get listPrague => this._listPrague;
  List<Company> get listCompany => this._listCompany;

  /// [SETTERS] - Grava os dados para armazenamento
  set login(Login login) {
    this._login = login;
    notifyListeners();
  } // set login(Login login) { ... }

  set pragues(List<Prague> pragues) {
    this._listPrague = pragues;
    notifyListeners();
  }

  set companies(List<Company> companies) {
    this._listCompany = companies;
    notifyListeners();
  } // set Company(List<Company> companies) { ... }

  /// [Constructor] - Dados para método construtor e-Praga
  EPraga() {
    this._login = null;
    this._listPrague = List<Prague>();
    this._listCompany = List<Company>();
    //this._listSchedule  = schedule;
  }

  factory EPraga.jsonData(Map<String, dynamic> json) {
    EPraga vReturn;
    vReturn._login = json['login'];

    vReturn._listPrague.clear();
    json['prague'].forEach((element) {
      vReturn._listPrague.add(Prague.fromJson(element));
    });

    vReturn._listCompany.clear();
    json['company'].forEach((element) {
      vReturn._listCompany.add(Company.fromJson(element));
    });

    return vReturn;
  } // factory EPraga.jsonData(Map<String, dynamic> json) { ... }

  // Opção para diagnóstico de informações
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('Login', this._login.toString()));
    properties.add(StringProperty('Prague', this._listPrague.toString()));
    properties.add(StringProperty('Company', this._listCompany.toString()));
    //properties.add(IntProperty('CPF', this._usuario));
  }
} // class EPraga with ChangeNotifier, DiagnosticableTreeMixin { ... }
