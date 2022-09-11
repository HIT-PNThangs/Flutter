import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/svg.dart';
import 'package:online_shop/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg"),
          onPressed: () {

          },
        ),
        actions: <Widget> [
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/search.svg", 
              color: kTextColor
            ), 
            onPressed: () {  },
          ),
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/cart.svg", 
              color: kTextColor
            ), 
            onPressed: () {  },
          ),
          const SizedBox(
            width: kDefaultPadding / 2,
          )
        ],
      ),
    );
  }
}
