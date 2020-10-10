import 'dart:async';
import 'package:epraga/allFiles.dart';

class Connectivity extends StatefulWidget {
  @override
  _Connectivity createState() => _Connectivity();
} // class Connectivity extends StatefulWidget { ... }

class _Connectivity extends State<Connectivity> {
  bool _connectivity  = true;
  Timer _lastTimer;

  @override
  void initState() {
    super.initState();
    VerifyNetwork().verify().then((value) {
      setState(() {
        this._connectivity = value;
      });
    });

    this._lastTimer = Timer.periodic(Duration(seconds: 10), (timerData){
      VerifyNetwork().verify().then((value){
        setState(() {
          this._connectivity  = value;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if(this._lastTimer != null) {
      _lastTimer.cancel();
    } // if(this._lastTimer != null) { ... }
  }

  @override
  Widget build(BuildContext context) {
    if (this._connectivity) {
      SenderController.senderData(context);
      return Container();
    } // if(this._connectivity) { ... }
    else {
      return Container(
        width: double.infinity,
        child: CardImage(
          title: Text(
            'Serviço de rede indisponível',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).backgroundColor,
                fontFamily: 'Roboto',
                //fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Atenção, você está operado no modo offline!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: Theme.of(context).backgroundColor,
            ),
          ),
          image: 'assets/animation/connection_error.flr',
          animation: 'idle',
          background: Colors.red[600],
        ),
      );
    } // else { ... }
  }
}