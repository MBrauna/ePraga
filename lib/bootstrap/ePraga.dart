import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../model/ePraga.dart';
import './../resources/allViews.dart';
import './../resources/theme/ePragaTheme.dart';

class EPraga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      key: Key('ePraga'),
      providers: [
        ChangeNotifierProvider(
          create: (_) => Epraga(),
        ),
      ],
      child: MaterialApp(
        home: Splash(),
        theme: EpragaTheme.light,
        routes: {
          '/Login': (context) => Login(),
        },
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class EPraga extends StatelessWidget { ... }
