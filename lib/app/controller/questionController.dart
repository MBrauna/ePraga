import 'package:epraga/allFiles.dart';
import 'package:epraga/config/config.dart' as config;

class QuestionController {
  static bool validateQuestion(BuildContext context, ItemSchudule schuduleItem) {
    int val_qtde  = 0;
    try {
      // Verifica se é uma visita e se ocorreu aplicação
      if(Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == schuduleItem.idItemSchudule)).visit) {
        Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == schuduleItem.idItemSchudule)).listQuestions.listVisit.forEach((element) {
          if(element.counter > 0) {
            val_qtde += 1;
          } // if(element.counter > 0) { ... }
        });
        // Se não existir marcação de produtos usados ...
        if(val_qtde <= 0) {
          return false;
        }
      } // if(Provider.of<App>(context).listSchudule.firstWhere((element) => (element.idSchudule == schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == schuduleItem.idItemSchudule)).visit) { ... }

      if(Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == schuduleItem.idItemSchudule)).listQuestions.ambienteAdequado == 0) {
        if(Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == schuduleItem.idItemSchudule)).listQuestions.naoConform.length <= 0) {
          return false;
        } // if(Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == schuduleItem.idItemSchudule)).listQuestions.naoConform.length <= 0) { ... }
      } // if(Provider.of<App>(context, listen: false).listSchudule.firstWhere((element) => (element.idSchudule == schuduleItem.idSchudule)).listItemSchudule.firstWhere((element) => (element.idItemSchudule == schuduleItem.idItemSchudule)).listQuestions.ambienteAdequado == 0) { ... }

      return true;
    }
    catch(error) {
      if(config.DEBUG) {
        print('[QuestionController][validateQuestion] ----------------');
        print(error);
        print('[QuestionController][validateQuestion] ----------------');
      }
      return false;
    }
  } // static bool validateQuestion(BuildContext context) { ... }
}