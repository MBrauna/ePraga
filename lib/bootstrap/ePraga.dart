import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../theme.dart';
import './../resources/page/splash.dart';
import './../model/app.dart';

class EPraga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      key: Key('EPragaApp'),
      providers: [
        ChangeNotifierProvider(
          create: (_) => App(),
        )
      ],
      child: MaterialApp(
        theme: EpragaTheme.light,
        home: Splash(),
      ),
    );
  } // Widget build(BuildContext context) { ... }
}
