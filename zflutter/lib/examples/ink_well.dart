import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../src/core/core.dart';
import '../src/widgets/widgets.dart';

class InkWell3D extends StatelessWidget {
  const InkWell3D({super.key});

  @override
  Widget build(BuildContext context) {
    return ZDragDetector(
      builder: (c, controller) => Center(
        child: ZIllustration(
          children: <Widget>[
            ZPositioned(
              rotate: controller.rotate,
              child: ZGroup(sortMode: SortMode.update, children: [
                ZPositioned(
                  translate: const ZVector.only(z: 300),
                  scale: const ZVector.all(1.1),
                  child: ZPositioned(
                    translate: const ZVector(100, 100, 0),
                    child: Box(
                      color: Colors.blue[100]!,
                      darkColor: Colors.blue[200]!,
                    ),
                  ),
                ),
                ZPositioned(
                  translate: const ZVector(-100, -100, 10),
                  child: Box(
                    color: Colors.red[100]!,
                    darkColor: Colors.red[200]!,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class Box extends StatefulWidget {
  final Color color;
  final Color darkColor;

  const Box({Key? key, required this.color, required this.darkColor}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Box> with TickerProviderStateMixin {
  int count = 0;

  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void tapped() {
    animationController.animateTo(1).then((value) => animationController.animateBack(0));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        final t = animationController.value;
        final darkColor = Color.lerp(widget.darkColor, widget.darkColor.darken(20), t);
        final color = Color.lerp(widget.color, widget.color.darken(20), t);
        return ZBoxToBoxAdapter(
          height: 300,
          width: 300,
          depth: 100,
          color: darkColor!,
          front: SizedBox(
            height: 300,
            width: 300,
            child: Material(
              color: color,
              child: InkWell(
                onTap: () {
                  print('tap hello');
                  tapped();
                  setState(() {
                    count += 1;
                  });
                },
                child: Center(
                  child: Text('$count'),
                ),
              ),
            ),
          ),
          rear: SizedBox(
            height: 300,
            width: 300,
            child: Material(
              color: color,
              child: InkWell(
                onTap: () {
                  print('tap hello');
                  tapped();
                  setState(() {
                    count += 1;
                  });
                },
                child: Center(
                  child: Text('$count'),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

extension on Color {
  Color brighten([int amount = 10]) {
    final color = Color.fromARGB(
      alpha,
      math.max(0, math.min(255, red - (255 * -(amount / 100)).round())),
      math.max(0, math.min(255, green - (255 * -(amount / 100)).round())),
      math.max(0, math.min(255, blue - (255 * -(amount / 100)).round())),
    );
    return color;
  }

  Color darken([int amount = 10]) {
    final value = -amount;
    final color = Color.fromARGB(
      alpha,
      math.max(0, math.min(255, red - (255 * -(value / 100)).round())),
      math.max(0, math.min(255, green - (255 * -(value / 100)).round())),
      math.max(0, math.min(255, blue - (255 * -(value / 100)).round())),
    );
    return color;
  }
}
