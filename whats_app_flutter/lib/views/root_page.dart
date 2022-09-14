import 'package:flutter/material.dart';
import 'package:whats_app_flutter/constants/colors.dart';
import 'package:whats_app_flutter/views/home/home_page.dart';
import 'package:whats_app_flutter/views/home/home_widgets.dart';
import 'package:whats_app_flutter/views/setting/setting_page.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

import 'call/call_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          backgroundColor: Colors.transparent,
          // child: GradientIconButton(iconData: Icons.search, size: 32),
          child: GradientIconButton(iconData: Icons.group_add, size: 55)
      ),
      body: getBody(),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget getBody() {
    switch(selectedIndex) {
      case 0:
        return const CallPage();

      case 1:
        return const HomePage();

      case 2:
        return const SettingPage();

      default:
        return const HomePage();
    }
  }

  Widget bottomNavigationBar() {
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: greenColor,
      strokeColor: Colors.white,
      unSelectedColor: const Color(0xff6c788a),
      backgroundColor: backgroundColor(context),
      items: [
        CustomNavigationBarItem(
          icon: const Icon(Icons.phone, size: 24),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.home, size: 24),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.settings, size: 24),
        ),
      ],
      currentIndex: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}