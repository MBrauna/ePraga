import 'dart:convert';

import 'package:epraga/allFiles.dart';

class SenderPage extends StatefulWidget {
  @override
  _SenderPage createState() => _SenderPage();
} // class SenderPage extends StatefulWidget { ... }

class _SenderPage extends State<SenderPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Builder(
      builder: (context){
        if(Provider.of<App>(context).listSender.length <= 0){
          return CardImage(
            image: 'assets/animation/message.flr',
            animation: 'name',
            background: Theme.of(context).backgroundColor,
            elevation: 3.0,
            title: Text('Nenhuma comunicação pendente!'),
            subtitle: Text('Realize os agendamentos para prosseguir.'),
          );
        } // if(Provider.of<App>(context).listSender.length <= 0){ ... }
        else {
          return Container(
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: Provider.of<App>(context).listSender.map((e){
                return Card(
                  elevation: 3.0,
                  color: Theme.of(context).backgroundColor,
                  child: Container(
                    width: size.width,
                    padding: EdgeInsets.only(
                      top: 20.0,
                      bottom: 20.0,
                    ),
                    child: ListTile(
                      title: Text(
                        'Aguardando envio #' + e.id.toString(),
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      subtitle: Text(
                        jsonDecode(e.content)['id_schudule_item'].toString(),
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  } // Widget build(BuildContext context) { ... }
} // class _SenderPage extends State<SenderPage> { ... }