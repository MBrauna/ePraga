import 'dart:async';

import 'package:flutter/material.dart';

import 'cardImage.dart';
import './../../app/util/verifyNetwork.dart';

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

    this._lastTimer = Timer.periodic(Duration(seconds: 60), (timerData){
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
      return Container();
    } // if(this._connectivity) { ... }
    else {
      return Container(
        width: double.infinity,
        child: CardImage(
          title: 'Serviço de rede indisponível',
          subtitle: 'Atenção, você está operado no modo offline!',
          image: 'assets/flare/connection_error.flr',
          animation: 'idle',
          alert: true,
        ),
      );
    } // else { ... }
  }
}