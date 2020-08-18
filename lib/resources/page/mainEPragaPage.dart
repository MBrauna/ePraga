import 'package:epraga/allFiles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainEpragaPage extends StatefulWidget {
  @override
  _MainEpragaPage createState() => _MainEpragaPage();
} // class MainEpragaPage extends StatefulWidget { ... }

class _MainEpragaPage extends State<MainEpragaPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Text('123'),
    ChatPage(),
    GuidePage(),
    UserPage(),
  ]; // List<Widget> _widgetOptions = <Widget>[ ... ]

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  } // void _onItemTapped(int index) { ... }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: Key('mainEpragaPage'),
      backgroundColor: Theme.of(context).backgroundColor,
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
      body: Builder(
        builder: (context) => Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Connectivity(),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    bottom: 50.0,
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  } // Widget build(BuildContext context) { ... }

} // class _MainEpragaPage extends State<MainEpragaPage> { ... }