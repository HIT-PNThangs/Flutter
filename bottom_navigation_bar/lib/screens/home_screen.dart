import 'package:flutter/material.dart';

import 'child_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  Widget childWidget = const ChildWidget(
    number: AvailableNumber.First,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[500],
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;

          switch (value) {
            case 0:
              childWidget = const ChildWidget(number: AvailableNumber.First);
              break;

            case 1:
              childWidget = const ChildWidget(number: AvailableNumber.Second);
              break;

            case 2:
              childWidget = const ChildWidget(number: AvailableNumber.Third);
              break;

            case 3:
              childWidget = const ChildWidget(number: AvailableNumber.Four);
              break;
          }

          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up), label: "Trending Up"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), label: "Dashboard"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), label: "Dashboard"
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: childWidget,
        ),
      ),
    );
  }
}
