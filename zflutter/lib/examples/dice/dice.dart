import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import '../../src/core/core.dart';
import '../../src/widgets/widgets.dart';

class Dices extends StatefulWidget {
  const Dices({super.key});

  @override
  _DicesState createState() => _DicesState();
}

class _DicesState extends State<Dices> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late SpringSimulation simulation;
  int num = 1;
  int num2 = 1;
  ZVector rotation = ZVector.zero;
  double zRotation = 0;

  @override
  void initState() {
    super.initState();

    simulation = SpringSimulation(
      const SpringDescription(
        mass: 1,
        stiffness: 20,
        damping: 2,
      ),
      1, // starting point
      0, // ending point
      1, // velocity
    );

    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))
      ..addListener(() {
        // rotation = rotation + ZVector.all(0.1);
        setState(() {});
      });
  }

  void random() {
    zRotation = Random().nextDouble() * tau;
    num = Random().nextInt(5) + 1;
    num2 = 6 - Random().nextInt(5);
  }

  @override
  Widget build(BuildContext context) {
    final curvedValue = CurvedAnimation(
      curve: Curves.ease,
      parent: animationController,
    );
    final firstHalf = CurvedAnimation(
      curve: const Interval(0, 1),
      parent: animationController,
    );
    final secondHalf = CurvedAnimation(
      curve: const Interval(0, 0.3),
      parent: animationController,
    );

    final zoom = (simulation.x(animationController.value)).abs() / 2 + 0.5;

    return GestureDetector(
      onTap: () {
        if (animationController.isAnimating) {
          animationController.reset();
        } else {
          animationController.forward(from: 0);
          random();
        }
      },
      child: Container(
        color: Colors.transparent,
        child: ZIllustration(
          zoom: 1.5,
          children: [
            ZPositioned(
              translate: ZVector.only(x: 100 * zoom),
              child: ZGroup(
                children: [
                  ZPositioned(
                    scale: ZVector.all(zoom),
                    rotate: getRotation(num2).multiplyScalar(curvedValue.value) -
                        ZVector.all((tau / 2) * (firstHalf.value)) -
                        ZVector.all((tau / 2) * (secondHalf.value)),
                    child: ZPositioned(
                        rotate: ZVector.only(z: -zRotation * 1.9 * (animationController.value)),
                        child: Dice(
                          zoom: zoom,
                          color: Colors.green,
                        )),
                  ),
                ],
              ),
            ),
            ZPositioned(
              translate: ZVector.only(x: -100 * zoom),
              child: ZGroup(
                children: [
                  ZPositioned(
                    scale: ZVector.all(zoom),
                    rotate: getRotation(num).multiplyScalar(curvedValue.value) -
                        ZVector.all((tau / 2) * (firstHalf.value)) -
                        ZVector.all((tau / 2) * (secondHalf.value)),
                    child: ZPositioned(
                        rotate: ZVector.only(z: -zRotation * 2.1 * (animationController.value)), child: Dice(zoom: zoom)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

ZVector getRotation(int num) {
  switch (num) {
    case 1:
      return ZVector.zero;
    case 2:
      return const ZVector.only(x: tau / 4);
    case 3:
      return const ZVector.only(y: tau / 4);
    case 4:
      return const ZVector.only(y: 3 * tau / 4);
    case 5:
      return const ZVector.only(x: 3 * tau / 4);
    case 6:
      return const ZVector.only(y: tau / 2);
  }
  throw ('num $num is not in the dice');
}

class Face extends StatelessWidget {
  final double zoom;
  final Color color;

  const Face({Key? key, this.zoom = 1, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZRect(
      stroke: 50 * zoom,
      width: 50,
      height: 50,
      color: color,
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return const ZCircle(
      diameter: 15,
      stroke: 0,
      fill: true,
      color: Colors.white,
    );
  }
}

class GroupTwo extends StatelessWidget {
  const GroupTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      sortMode: SortMode.update,
      children: const [
        ZPositioned(translate: ZVector.only(y: -20), child: Dot()),
        ZPositioned(translate: ZVector.only(y: 20), child: Dot()),
      ],
    );
  }
}

class GroupFour extends StatelessWidget {
  const GroupFour({super.key});

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      sortMode: SortMode.update,
      children: const [
        ZPositioned(translate: ZVector.only(x: 20, y: 0), child: GroupTwo()),
        ZPositioned(translate: ZVector.only(x: -20, y: 0), child: GroupTwo()),
      ],
    );
  }
}

class Dice extends StatelessWidget {
  final Color color;
  final double zoom;

  const Dice({Key? key, this.zoom = 1, this.color = const Color(0xffF23726)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ZGroup(
          sortMode: SortMode.update,
          children: [
            ZPositioned(translate: const ZVector.only(z: -25), child: Face(zoom: zoom, color: color)),
            ZPositioned(translate: const ZVector.only(z: 25), child: Face(zoom: zoom, color: color)),
            ZPositioned(
                translate: const ZVector.only(y: 25),
                rotate: const ZVector.only(x: tau / 4),
                child: Face(
                  zoom: zoom,
                  color: color,
                )),
            ZPositioned(
                translate: const ZVector.only(y: -25),
                rotate: const ZVector.only(x: tau / 4),
                child: Face(zoom: zoom, color: color)),
          ],
        ),
        //one
        const ZPositioned(translate: ZVector.only(z: 50), child: Dot()),
        //two
        ZPositioned(
          rotate: const ZVector.only(x: tau / 4),
          translate: const ZVector.only(y: 50),
          child: ZGroup(
            sortMode: SortMode.update,
            children: const [
              ZPositioned(translate: ZVector.only(y: -20), child: Dot()),
              ZPositioned(translate: ZVector.only(y: 20), child: Dot()),
            ],
          ),
        ),
        //three
        ZPositioned(
          rotate: const ZVector.only(y: tau / 4),
          translate: const ZVector.only(x: 50),
          child: ZGroup(
            sortMode: SortMode.update,
            children: const [
              Dot(),
              ZPositioned(translate: ZVector.only(x: 20, y: -20), child: Dot()),
              ZPositioned(translate: ZVector.only(x: -20, y: 20), child: Dot()),
            ],
          ),
        ),
        //four
        ZPositioned(
          rotate: const ZVector.only(y: tau / 4),
          translate: const ZVector.only(x: -50),
          child: ZGroup(
            sortMode: SortMode.update,
            children: const [
              ZPositioned(translate: ZVector.only(x: 20, y: 0), child: GroupTwo()),
              ZPositioned(translate: ZVector.only(x: -20, y: 0), child: GroupTwo()),
            ],
          ),
        ),

        //five
        ZPositioned(
          rotate: const ZVector.only(x: tau / 4),
          translate: const ZVector.only(y: -50),
          child: ZGroup(
            sortMode: SortMode.update,
            children: const [
              Dot(),
              ZPositioned(child: GroupFour()),
            ],
          ),
        ),

        //six
        ZPositioned(
          translate: const ZVector.only(z: -50),
          child: ZGroup(
            sortMode: SortMode.update,
            children: const [
              ZPositioned(rotate: ZVector.only(z: tau / 4), child: GroupTwo()),
              ZPositioned(child: GroupFour()),
            ],
          ),
        ),
      ],
    );
  }
}
