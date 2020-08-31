import 'package:epraga/allFiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EPraga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>  App(),
        ),
      ],
      child: MaterialApp(
        key: Key('ePraga'),
        debugShowCheckedModeBanner: false,
        darkTheme: EpragaTheme.dark,
        theme: EpragaTheme.light,
        home: SplashPage(),
      ),
    );
  } // Widget builld(BuildContext context) { ... }
} // class EPraga extends StatefulWidget { ... }