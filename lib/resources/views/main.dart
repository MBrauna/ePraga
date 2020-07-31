import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './../allViews.dart';

class MainEpraga extends StatefulWidget {
  @override
  _MainEpraga createState() => _MainEpraga();
} // class MainEpraga extends StatefulWidget { ... }

class _MainEpraga extends State<MainEpraga> {
  int _idxPage = 0;

  List<Widget> _listPages = <Widget>[
    // Página de desempenhos
    Center(child: Text('Desempenho'),),
    // Página de Agenda
    Center(child: Text('Agenda'),),
    // Página de Concluídos
    Center(child: Text('Concluidas'),),
    // Página de Dados do usuáriousuário
    Center(child: Text('Desempenho'),),
  ];

  void _onItemTapped(int index) {
    setState(() {
      this._idxPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color bottonBarColor = Color(0xff1a237e);
    Size size = MediaQuery.of(context).size;
    double fonteTitulo    = ((MediaQuery.of(context).orientation == Orientation.landscape)  ? (size.width / 40) : (size.width / 20));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        elevation: 10.0,
        centerTitle: true,
        title: Text('ePraga',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: fonteTitulo,
            fontWeight: FontWeight.bold,
          )
        ),
      ),
      extendBody: true,
      key: Key('MainEpraga'),
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 16.0,
        type: BottomNavigationBarType.shifting,
        currentIndex: this._idxPage,
        onTap: this._onItemTapped,
        elevation: 10.0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.chartPie,
            ),
            title: Text('Desempenho'),
            backgroundColor: bottonBarColor,
          ),

          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.businessTime,
            ),
            title: Text('Agenda'),
            backgroundColor: bottonBarColor,
          ),

          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.archive
            ),
            title: Text('Concluído'),
            backgroundColor: bottonBarColor,
          ),

          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidUserCircle
            ),
            title: Text('Usuário'),
            backgroundColor: bottonBarColor,
          ),
        ],
      ),
      body: Builder(
        builder: (context) => this._listPages.elementAt(this._idxPage),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _MainEpraga extends State<MainEpraga> { ... }
