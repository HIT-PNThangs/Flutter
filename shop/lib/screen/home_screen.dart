import 'package:flutter/material.dart';
import 'package:shop/screen/components/body.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.keyboard_backspace_outlined, color: kTextColor),
        onPressed: () {
        },
      ),
      actions: <Widget> [
        IconButton(
          icon: const Icon(Icons.search, color: kTextColor),
          onPressed: () {  },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: kTextColor),
          onPressed: () {  },
        ),
        const SizedBox(
          width: kDefaultPadding / 2,
        )
      ],
    );
  }
}
