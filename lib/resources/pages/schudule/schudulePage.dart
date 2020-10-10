import 'package:epraga/allFiles.dart';
import 'package:intl/intl.dart';

class SchudulePage extends StatefulWidget {
  @override
  _SchudulePage createState() =>  _SchudulePage();
} // class SchudulePage extends StatefulWidget { ... }

class _SchudulePage extends State<SchudulePage> {
  bool _execFirst = true, _btnExec = false;

  @override
  Widget build(BuildContext context) {
    Size    size                = MediaQuery.of(context).size;
    double  fonteTitulo         = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 40) : (size.width / 20));

    return Builder(
      builder: (context){
        if(_execFirst){
          _btnExec = true;
          // Ao abrir a tela ele buscará atualizar
          SchuduleController.requestSchudule(context).then((returnSchudule){
            setState(() {
              _execFirst  = false;
              _btnExec    = false;
            });
          }); // SchuduleController.requestSchudule(context).then((returnSchudule){ ... }
        } // if(_execFirst){ ... }
        

        return Container(
          key: Key('SchudulePage'),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // -- CABEÇALHO -- //
                CardImage(
                  image: 'assets/animation/logo.flr',
                  animation: 'splash',
                  background: Colors.blue,
                  title: Text(
                    'EPraga',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SystemAnalysis',
                      color: Theme.of(context).backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: fonteTitulo,
                    ),
                  ),
                  subtitle: Text(
                    'Agendamentos disponíveis\nem ' + DateFormat('dd/MM/yyyy').format(DateTime.now()),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                // -- PARA VERIFICAR CONEXÃO DE REDE -- //
                Connectivity(),

                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Atualizar dados',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    onPressed: (){
                      if(_btnExec) {
                        Message(context).info('Em atualização! Aguarde.',tempo: 1);
                      }
                      else {
                        setState((){
                          _btnExec = true;
                        });

                        SchuduleController.requestSchudule(context).then((value){
                          setState((){
                            _btnExec = false;
                          });
                        });
                      }
                    },
                  ),
                ),


                // -- LISTA DE DADOS -- //
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Provider.of<App>(context).listSchudule.length,
                  itemBuilder: (BuildContext ctx, int idx) {
                    return SchuduleElement(Provider.of<App>(context).listSchudule.elementAt(idx));
                  }
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} // class _SchudulePage extends State<SchudulePage> { ... }