import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './../allViews.dart';

class MainEpraga extends StatefulWidget {
  @override
  _MainEpraga createState() => _MainEpraga();
} // class MainEpraga extends StatefulWidget { ... }

class _MainEpraga extends State<MainEpraga> {
  int _selectedIndex = 2;

  List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
    ),
    Text(
      'Index 3: teste',
    ),
    User(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Builder(
      builder: (context) => Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).backgroundColor,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).disabledColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.book),
              title: Text('Manual'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.chartPie,),
              title: Text('Desempenho'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.shieldVirus,
                size: 30.0,
              ),
              title: Text('Agendamento'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidComments),
              title: Text('Mensagem'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.cogs),
              title: Text('Configurações'),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _widgetOptions.elementAt(_selectedIndex),
            ],
          ),
        ),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _MainEpraga extends State<MainEpraga> { ... }
