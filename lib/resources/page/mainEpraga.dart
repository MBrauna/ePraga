import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './../component/connectivity.dart';
import './../allPages.dart';

class MainEpraga extends StatefulWidget {
  @override
  _MainEpraga createState() => _MainEpraga();
} // class MainEpraga extends StatefulWidget { ... }

class _MainEpraga extends State<MainEpraga> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Schudule(),
    Text(
      'Index 2: Status',
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
      key: Key('MainEPraga'),
      builder: (context) => Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).backgroundColor,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).disabledColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.businessTime,),
              title: Text('Agendamento'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidComments),
              title: Text('Comunicação'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.book),
              title: Text('Manual'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.cogs),
              title: Text('Configuração'),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Connectivity(),
              _widgetOptions.elementAt(_selectedIndex),
            ],
          ),
        ),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _MainEpraga extends State<MainEpraga> { ... }
