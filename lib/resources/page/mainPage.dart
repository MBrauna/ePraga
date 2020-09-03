import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:epraga/allFiles.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
} // class MainPage extends StatefulWidget { ... }

class _MainPage extends State<MainPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    SchudulePage(),
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
  void initState(){
    super.initState();
  } // void initState(){ ... }

  @override
  Widget build(BuildContext context) {

    // Ficará monitorando o login, no momento que expirar irá enviar a tela de login
    if(context.watch<App>().login == null  || context.watch<App>().login.expiredLogin.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch) {
      Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Sessão expirou! Realize o login para prosseguir.',)));
    } // if(context.watch<App>().login == null  || context.watch<App>().login.expiredLogin.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch) { ... }

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
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
          ),
          child: Center(
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
        )
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _MainPage extends State<MainPage> { ... }