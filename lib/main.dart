import 'package:flutter/material.dart';
import 'package:flutterfirestoretest/features/home/HomeScreen.dart';
import 'package:flutterfirestoretest/features/languages/LanguagesProvider.dart';
import 'package:flutterfirestoretest/features/main/AppProvider.dart';
import 'package:provider/provider.dart';

import 'features/languages/LanguagesScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (_) => AppProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, child) {
      return MaterialApp(
        theme: provider.isDarkModeOn ? provider.darkTheme : provider.lightTheme,
        initialRoute: HomeScreen.tag,
        routes: {
          HomeScreen.tag: (context) => HomeScreen(),
          LanguagesScreen.tag: (context) => LanguagesScreen()
        },
      );
    });
  }
}
