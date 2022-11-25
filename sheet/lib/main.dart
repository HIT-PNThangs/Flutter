import 'package:flutter/material.dart';

import 'route_example_page.dart';
import 'sheet_example_page.dart';
import 'src/route/base_route_extended.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(platform: TargetPlatform.iOS),
      debugShowCheckedModeBanner: false,
      title: 'BottomSheet Modals',
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/') {
          return MaterialExtendedPageRoute<void>(
            builder: (BuildContext context) {
              return const BottomNavigationScaffold();
            },
          );
        }
        return null;
      },
    );
  }
}

class BottomNavigationScaffold extends StatefulWidget {
  const BottomNavigationScaffold({super.key});

  @override
  State<BottomNavigationScaffold> createState() => _BottomNavigationScaffoldState();
}

class _BottomNavigationScaffoldState extends State<BottomNavigationScaffold> {
  int _currentNavitagionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: IndexedStack(
            index: _currentNavitagionIndex,
            children: const <Widget>[
              SheetExamplesPage(),
              RouteExamplePage(),
            ],
          ),
        ),
        BottomNavigationBar(
            currentIndex: _currentNavitagionIndex,
            onTap: (int value) {
              setState(() {
                _currentNavitagionIndex = value;
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.pages), label: 'Sheet'),
              BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Route'),
            ])
      ],
    );
  }
}
