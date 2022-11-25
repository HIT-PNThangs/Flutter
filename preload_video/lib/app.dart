import 'package:flutter/material.dart';
import './app/screen/home/home_screen.dart';

import './app/screen/main_screen.dart';
import './app/style/theme.dart' as style;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          textTheme: ThemeData.dark().textTheme.apply(
                fontFamily: 'Nunito',
              ),
          primaryTextTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Nunito'),
          scaffoldBackgroundColor: style.Colors.scaffoldDarkBack,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
              selectedItemColor: style.Colors.mainColor,
              selectedIconTheme: IconThemeData(color: style.Colors.mainColor),
              unselectedItemColor: Colors.white)),
      home: const MainScreen(),
    );
  }
}
