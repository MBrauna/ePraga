import 'package:epraga/allFiles.dart';

class EPragaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      key: Key('ePragaApp'),
      providers: [
        ChangeNotifierProvider(
          // Configurações das aplicações - EPraga
          create: (context) => EPraga(),
        ),
        ChangeNotifierProvider(
          create: (context) => ListData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: EpragaTheme.dark,
        theme: EpragaTheme.light,
        home: SplashPage(),
      ),
    );
  }
} // class EPragaApp extends StatelessWidget { .. }