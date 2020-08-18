import 'package:flutter/material.dart';
import 'package:epraga/allFiles.dart';
import 'package:provider/provider.dart';

class SchuduleController {
  static Future<bool> getGuide(BuildContext context) async {
    try {
      String hash = context.read<App>().login.hash;
      Map<String, dynamic> request = await SchuduleRequest.getSchudule(hash);

      if(request['status'] == 200) {
        List<Schudule> schuduleList = List<Schudule>();

        request['schudule'].forEach((element) {
          Schudule schudule = Schudule.fromJson(element);
          schuduleList.add(schudule);
        });

        context.read<App>().schudule = schuduleList;
        await DataController.setDatabaseData(context, ['schudule']);
        return true;
      } // if(request['status'] == 200) { ... }
      else {
        return false;
      }
    }
    catch(error) {
      Message(context).error('Não foi possível atualizar os manuais!',tempo: 2);
      return false;
    }
  } // static Future<bool> getGuide(BuildContext context) async { ... }
}