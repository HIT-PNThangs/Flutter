import 'package:flutter/material.dart';

import 'src/core/core.dart';
import 'src/widgets/widgets.dart';

class BugFix extends StatelessWidget {
  const BugFix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZIllustration(
      children: [
        ZGroup(
          //   sortMode: SortMode.update,
          children: [
            const ZBox(width: 40, height: 40, depth: 40, color: Colors.red),
            ZGroup(
              children: [
                ZPositioned(
                  translate: const ZVector(0, 0, 100),
                  child: AnimatedCircle(
                    child: ZGroup(sortMode: SortMode.update, children: const [
                      ZCircle(
                        diameter: 20,
                        color: Colors.blue,
                        fill: true,
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class AnimatedCircle extends StatefulWidget {
  const AnimatedCircle({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<AnimatedCircle> createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle> with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(vsync: this, duration: const Duration(seconds: 4));

  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      rotate: ZVector(0, tau * controller.value, 0),
      child: widget.child,
    );
  }
}
