import 'package:flutter/material.dart';

import './../../component/cardImage.dart';

class Chat extends StatefulWidget {
  @override
  _Chat createState() => _Chat();
} // class Chat extends StatefulWidget { ... }

class _Chat extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: (size.height/3),
      ),
      child: CardImage(
        title: 'Você não possui mensagens!',
        subtitle: 'Fique tranquilo no momento que ela chegar irei avisar.',
        image: 'assets/flare/robot.flr',
        animation: 'reposo',
      ),
    );
  }
} // class _Chat extends State<Chat> { ... }