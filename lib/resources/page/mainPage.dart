import 'package:epraga/allFiles.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
} // class MainPage extends StatefulWidget { ... }


class _MainPage extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  void initState(){
    super.initState();
  } // void initState(){ ... }

  @override
  Widget build(BuildContext context) {

    // Ficará monitorando o login, no momento que expirar irá enviar a tela de login
    if(context.watch<EPraga>().login == null  || context.watch<EPraga>().login.expiredLogin.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch) {
      Navigator.pushReplacement(context, FadePageRoute(LoginPage(message: 'Sessão expirou! Realize o login para prosseguir.',)));
    } // if(context.watch<EPraga>().login == null  || context.watch<EPraga>().login.expiredLogin.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch) { ... }

    return Builder(
      builder: (context) => Scaffold(
        key: Key('mainEpragaPage'),
        extendBody: true,
        body: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 20.0,
            ),
            child: Center(
              child: IndexedStack(
                index: this._selectedIndex,
                children: allDestinations.map<Widget>((Destination destination){
                  return new Container(child: destination.widget);
                }).toList(),
              ),
            )
          )
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._selectedIndex,
          onTap: (int idx){
            setState(() {
              this._selectedIndex = idx;
            });
          },
          backgroundColor: Theme.of(context).backgroundColor,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).disabledColor,
          items: allDestinations.map((Destination destination){
            return BottomNavigationBarItem(
              icon: FaIcon(destination.icon),
              title: Text(destination.title),
            );
          }).toList(),
        ),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _MainPage extends State<MainPage> { ... }