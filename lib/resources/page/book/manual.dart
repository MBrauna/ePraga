import 'package:flutter/material.dart';
import './../../component/cardImage.dart';

class Manual extends StatefulWidget {
  @override
  _Manual createState() => _Manual();
}

class _Manual extends State<Manual> {
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
        title: 'Nenhum manual cadastrado!',
        subtitle: 'Oops, não há um manual cadastrado! Aguarde lançamento.',
        image: 'assets/flare/empty_state.flr',
        animation: 'idle',
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _Manual extends State<Manual> { ... }