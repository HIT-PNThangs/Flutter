import 'package:flutter/material.dart';

import '../widgets/destinations.dart';
import '../widgets/topmenu.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[topMenu(), destination(context)],
    );
  }
}
