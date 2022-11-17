import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'routes.dart';
import 'screens/pager.dart';

void main() {
  Routes.initRoutes();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'MENU',
    home: MenuHomePage(),
  ));
}

class MenuHomePage extends StatelessWidget {
  MenuHomePage({super.key}) {
    SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          MenuPager(),
        ],
      ),
    );
  }
}
