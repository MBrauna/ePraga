import 'package:epraga/allFiles.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPage createState() => _ChatPage();
} // class ChatPage extends StatefulWidget { ... }

class _ChatPage extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return CardImage(
      title: Text(
        'Você não possui mensagens!',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      subtitle: Text(
        '\n\n\n\nBip bip bop!\nIrei informar quando algo chegar!',
        textAlign: TextAlign.center,
      ),
      image: 'assets/flare/message.flr',
      animation: 'go',
    );
  }
}