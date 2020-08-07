import 'package:epraga/resources/view/auth/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../model/allModels.dart';
import './../theme/ePragaTheme.dart';

class EPragaBootstrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      key: Key('ePraga'),
      providers: [
        ChangeNotifierProvider(
          create: (_) => EPraga(),
        ), // ChangeNotifierProvider({...});
      ],
      child: MaterialApp(
        home: Splash(),
        theme: EpragaTheme.light,
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class EPraga extends StatelessWidget { ... }
