import 'package:epraga/allFiles.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
} // class MainPage extends StatefulWidget { ... }

class _MainPage extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('MainPage'),
      extendBody: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Builder(
        builder: (ctx) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                  left: 15.0,
                  right: 15.0,
                ),
              child: IndexedStack(
                index: this._selectedIndex,
                children: allDestinations.map<Widget>((Destination destination){
                  return new Container(child: destination.widget);
                }).toList(),
              ),
            ),
          );
        },
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
            // ignore: deprecated_member_use
            title: Text(destination.title),
          );
        }).toList(),
      ),
    );

  } // Widget build(BuildContext context) { ... }
} // class _MainPage extends State<MainPage> { ... }