import 'package:epraga/allFiles.dart';
import 'package:epraga/config/config.dart' as config;

class EPraga extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      key: Key('ePragaApp'),
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => App(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Mobile(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: config.DEBUG,
        theme: EpragaTheme.light,
        darkTheme: EpragaTheme.light,
        home: SplashPage(),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class EPraga extends StatelessElement { ... }