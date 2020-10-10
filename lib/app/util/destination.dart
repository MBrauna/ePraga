import 'package:epraga/allFiles.dart';

class Destination {
  Destination(this.title, this.icon, this.widget);

  String title;
  IconData icon;
  Widget widget;
}

List<Destination> allDestinations = <Destination>[
  Destination('Agendamento', FontAwesomeIcons.businessTime, SchudulePage()),
  Destination('Comunicação', FontAwesomeIcons.solidComment, Text('123')),
  Destination('Servidor', FontAwesomeIcons.solidPaperPlane, Text('123')),
  Destination('Usuário', FontAwesomeIcons.solidUserCircle, UserPage()),
];