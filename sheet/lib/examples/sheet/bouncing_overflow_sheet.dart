import 'package:flutter/material.dart';

import '../../src/physics.dart';
import '../../src/sheet.dart';

class BounceOverflowSheet extends StatelessWidget {
  const BounceOverflowSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Sheet(
      physics: const BouncingSheetPhysics(overflowViewport: false),
      minExtent: 100,
      child: Scaffold(
        appBar: AppBar(title: const Text('Example')),
      ),
    );
  }
}
