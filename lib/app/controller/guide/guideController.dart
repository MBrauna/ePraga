import 'package:flutter/material.dart';
import 'package:epraga/allFiles.dart';
import 'package:provider/provider.dart';

class GuideController {
  static Future<bool> getGuide(BuildContext context,{String hash}) async {
    try {
      Map<String, dynamic> request = await GuideRequest.getGuide(hash);

      if(request['status'] == 200) {
        List<Guide> guideList = List<Guide>();

        request['guide'].forEach((element) {
          Guide guide = Guide.fromJson(element);
          guideList.add(guide);
        });

        context.read<App>().guide = guideList;
        await DataController.setDatabaseData(context, ['guide']);
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
  } // static Future<bool> getGuide(BuildContext context) { ... }
} // class GuideController { ... }