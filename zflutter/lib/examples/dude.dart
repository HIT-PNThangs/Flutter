import 'package:flutter/material.dart';

import '../src/core/core.dart';
import '../src/widgets/widgets.dart';

const Color offWhite = Color(0xffFFEEDD);
const Color gold = Color(0xffEEAA00);

const Color garnet = Color(0xffCC2255);

const Color eggplant = Color(0xff663366);

class Hand extends StatelessWidget {
  final ZVector translate;

  const Hand({Key? key, required this.translate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      translate: translate,
      child: ZShape(stroke: 6, color: gold),
    );
  }
}

class Arm extends StatelessWidget {
  final double armSize = 6;
  final ZVector translate;
  final ZVector rotate;

  const Arm({Key? key, required this.translate, required this.rotate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      translate: translate,
      rotate: rotate,
      child: ZGroup(children: [
        ZShape(color: eggplant, stroke: 4, path: [
          const ZMove.vector(ZVector.only(y: 0)),
          ZLine.vector(
            ZVector.only(y: armSize),
          )
        ]),
        ZGroup(
          children: [
            ZPositioned(
                translate: ZVector.only(y: armSize),
                rotate: const ZVector.only(x: tau / 8),
                child: ZGroup(
                  children: [
                    ZShape(
                      path: [const ZMove.vector(ZVector.only(y: 0)), ZLine.vector(ZVector.only(y: armSize))],
                      color: gold,
                      stroke: 4,
                    ),
                    ZPositioned(
                      translate: ZVector.only(z: 1, y: armSize),
                      child: ZShape(
                        stroke: 6,
                        color: gold,
                      ),
                    ),
                    Hand(
                      translate: ZVector.only(z: 1, y: armSize),
                    ),
                  ],
                ))
          ],
        )
      ]),
    );
  }
}

class Eye extends StatelessWidget {
  final ZVector translate;

  const Eye({Key? key, required this.translate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      translate: translate,
      rotate: const ZVector.only(z: -tau / 4),
      child: const ZCircle(
        diameter: 2,
        quarters: 2,
        color: eggplant,
        stroke: 0.5,
        // backface: false,
      ),
    );
  }
}

class Head extends StatelessWidget {
  const Head({super.key});

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
        translate: const ZVector.only(y: -9.5),
        child: ZGroup(
          children: [
            ZShape(
              stroke: 12,
              color: gold,
            ),
            ZGroup(children: const [
              Eye(translate: ZVector.only(x: -2, y: 1, z: 4.5)),
              Eye(translate: ZVector.only(x: 2, y: 1, z: 4.5)),
              ZPositioned(
                translate: ZVector.only(y: 2.5, z: 4.5),
                rotate: ZVector.only(z: tau / 4),
                child: ZCircle(
                  diameter: 3,
                  quarters: 2,
                  closed: true,
                  color: Color(0xFFFFEEDD),
                  stroke: 0.5,
                  fill: true,
                  //backface: false
                ),
              )
            ])
          ],
        ));
  }
}

class Leg extends StatelessWidget {
  final double xTranslation;
  final double rotation;

  const Leg({Key? key, required this.xTranslation, required this.rotation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      translate: ZVector.only(x: xTranslation),
      rotate: ZVector.only(x: rotation),
      child: ZGroup(
        children: [
          ZShape(color: eggplant, stroke: 4, path: [
            const ZMove.vector(ZVector.only(y: 0)),
            ZLine.vector(const ZVector.only(y: 12)),
          ]),
          // foot
          ZPositioned(
            translate: const ZVector.only(y: 14, z: 2),
            rotate: ZVector.only(x: rotation),
            child: const ZRoundedRect(
              width: 2,
              height: 4,
              borderRadius: 1,
              color: garnet,
              fill: true,
              stroke: 4,
            ),
          )
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return ZDragDetector(builder: (context, controller) {
      const hipX = 3.0;
      // ----- upper body ----- //
      final spine = ZPositioned(
        rotate: const ZVector.only(x: tau / 8),
        translate: const ZVector.only(y: -6.5),
        child: ZGroup(
          children: [
            ZShape(
              //Chest
              path: [
                const ZMove.vector(ZVector.only(x: -1.5)),
                ZLine.vector(const ZVector.only(x: 1.5)),
              ],

              stroke: 9,
              color: garnet,
            ),
            const Head(),
            const Arm(translate: ZVector.only(x: -5, y: -2), rotate: ZVector.only(x: -tau / 4)),
            const Arm(translate: ZVector.only(x: 5, y: -2), rotate: ZVector.only(x: tau / 4))
          ],
        ),
      );
      // hips
      final hips = ZPositioned(
        translate: const ZVector.only(y: 2),
        child: ZGroup(
          children: [
            ZShape(
              path: [
                const ZMove.vector(ZVector.only(x: -hipX)),
                ZLine.vector(const ZVector.only(x: hipX)),
              ],
              stroke: 4,
              color: eggplant,
            ),
            const Leg(xTranslation: -hipX, rotation: tau / 4),
            const Leg(xTranslation: hipX, rotation: -tau / 8),
            spine
          ],
        ),
      );

      return ZIllustration(zoom: 10, children: [
        ZPositioned(
            rotate: controller.rotate.copy(), //..y += -TAU / 8,
            child: hips)
      ]);
    });
  }
}
