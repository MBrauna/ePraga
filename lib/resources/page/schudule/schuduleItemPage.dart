import 'package:epraga/allFiles.dart';

// ignore: must_be_immutable
class SchuduleItemPage extends StatefulWidget {
  Schudule data;

  SchuduleItemPage(this.data);

  @override
  _SchuduleItemPage createState() => _SchuduleItemPage();
} // class SchuduleItemPage extends StatefulWidget { ... }

class _SchuduleItemPage extends State<SchuduleItemPage> {
  @override
  Widget build(BuildContext context) {
    Size    size                = MediaQuery.of(context).size;
    double  fonteTitulo         = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 40) : (size.width / 20));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.data.description,
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView.builder(
        itemCount: Provider.of<ListData>(context).listSchudule.where((element) => element.id == widget.data.id).first.schuduleItem.length,
        itemBuilder: (context, index) {
          return new Card(
            elevation: 3.0,
            child: Container(
              width: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Provider.of<ListData>(context).listSchudule.where((element) => element.id == widget.data.id).first.schuduleItem.elementAt(index).description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: fonteTitulo,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    
                    Text(
                      '______________',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 8.0,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Text(
                      '______________',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 8.0,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    


                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _SchuduleItemPage extends State<SchuduleItemPage> { ... }