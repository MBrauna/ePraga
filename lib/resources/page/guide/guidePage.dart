import 'package:epraga/allFiles.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePage createState() => _GuidePage();
} // class GuidePage extends StatefulWidget { ... }

class _GuidePage extends State<GuidePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: RaisedButton(
            onPressed: () async {
            },
            color: Theme.of(context).accentColor,
            child: Text(
              'Atualizar manuais',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),


        CardImage(
          image: 'assets/flare/empty_state.flr',
          animation: 'idle',
          background: Colors.deepOrangeAccent,
          title: Text(
            'Nenhum manual encontrado!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),
          ),
          subtitle: Text(
            '\n\n\nOhhh não!\nNenhum manual está disponível para leitura neste momento, tente novamente mais tarde.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.normal
            ),
          ),
        )
      ],
    );
  } // Widget build(BuildContext context) { ... }
} // class _GuidePage extends State<GuidePage> { .. }