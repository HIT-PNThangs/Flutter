import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'trending.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const <Widget>[
          Trending(),
        ],
        onPageChanged: (int index) {
          setState(
            () {
              currentIndex = index;
            },
          );
        },
      ),
      bottomNavigationBar: bottomItems(),
    );
  }

  BottomNavigationBar bottomItems() {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.pink[300],
      unselectedItemColor: Colors.white,
      elevation: 0.5,
      onTap: (int index) {
        setState(
          () {
            currentIndex = index;
          },
        );
      },
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: tikTokLog(),
          label: "",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.indeterminate_check_box),
          label: "",
        ),
        const BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.userAlt),
          label: "",
        ),
      ],
    );
  }

  Widget tikTokLog() {
    return SizedBox(
      width: 45.0,
      height: 27.0,
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            width: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: Colors.pink[300],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            width: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: Colors.blue[200],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            width: 30.0,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: Colors.white,
            ),
            child: const Icon(Icons.add, color: Colors.black),
          )
        ],
      ),
    );
  }
}
