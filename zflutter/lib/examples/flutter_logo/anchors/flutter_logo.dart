import 'package:flutter/material.dart';

import '../../../src/core/core.dart';
import '../../../src/widgets/group.dart';

class FlutterAnchor extends StatelessWidget {
  const FlutterAnchor({super.key});

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
        scale: const ZVector.all(3),
        child: ZGroup(
          children: [
            ZLineTop(
              bottomLeft: const ZVector.only(x: 0, y: -3.81),
              bottomRight: const ZVector.only(x: 3.81, y: 0),
              topRight: const ZVector.only(x: 20, y: -16.8),
              topLeft: const ZVector.only(x: 12.37, y: -16.8),
              z: -5,
              front: Colors.blue[400]!,
              side: Colors.blue[500]!,
              inside: Colors.blue[600]!,
            ),
            ZPositioned(
              translate: const ZVector.only(x: 5.7, y: 6.2),
              child: ZGroup(children: [
                MiddleZLine(
                  bottomLeft: const ZVector.only(x: 3.9, y: -7.8),
                  bottomRight: const ZVector.only(x: 7.6, y: -4),
                  topRight: const ZVector.only(x: 14.27, y: -10.5),
                  topLeft: const ZVector.only(x: 6.65, y: -10.5),
                  z: -5,
                  front: Colors.blue[400]!,
                  side: Colors.blue[500]!,
                  inside: Colors.blue[600]!,
                ),
              ]),
            ),
            ZPositioned(
              translate: const ZVector.only(x: 5.7, y: -1.5),
              child: ZGroup(children: [
                BottomZLine(
                  bottomLeft: const ZVector.only(x: 5.9, y: 9.8),
                  bottomRight: const ZVector.only(x: 13.57, y: 9.8),
                  topRight: const ZVector.only(x: 3.8, y: 0),
                  topLeft: const ZVector.only(x: 0, y: 3.8),
                  middleRight: const ZVector.only(x: 7.6, y: 3.8),
                  z: -5,
                  back: Colors.blue[400]!,
                  front: Colors.blue[900]!,
                  side: Colors.blue[900]!,
                  inside: Colors.blue[600]!,
                ),
              ]),
            ),
          ],
        ));
  }
}

class ZLineTop extends StatelessWidget {
  final ZVector translate;
  final ZVector bottomLeft;
  final ZVector bottomRight;
  final ZVector topRight;
  final ZVector topLeft;
  final double z;
  final Color front;
  final Color inside;
  final Color side;

  const ZLineTop({
    super.key,
    this.translate = ZVector.zero,
    required this.bottomLeft,
    required this.bottomRight,
    required this.topRight,
    required this.topLeft,
    required this.z,
    required this.front,
    required this.inside,
    required this.side,
  });

  @override
  Widget build(BuildContext context) {
    const stroke = 0.0;
    const height = 4.0;

    final frontZShape = ZShape(path: [
      ZMove.vector(bottomLeft),
      ZLine.vector(bottomRight),
      ZLine.vector(topRight),
      ZLine.vector(topLeft),
    ], color: front, fill: true, stroke: 2);

    final topZShape = ZGroup(sortMode: SortMode.update, children: [
      ZPositioned(
        translate: const ZVector.only(z: -stroke),
        child: ZShape(
          path: [
            ZMove.vector(topRight),
            ZLine.vector(topLeft),
            ZLine.vector(topLeft.copyWith(z: -height)),
            ZLine.vector(topRight.copyWith(z: -height)),
          ],
          front: (topRight - topLeft).cross(const ZVector.only(z: height)),
          fill: true,
          stroke: 2,
          color: side,
          backfaceColor: inside,
        ),
      ),
      ZPositioned(
        translate: const ZVector.only(y: -10),
        child: ZShape(
          path: [
            ZMove.vector(topRight),
            ZLine.vector(topLeft),
            ZLine.vector(topLeft.copyWith(z: -height)),
            ZLine.vector(topRight.copyWith(z: -height)),
          ],
          visible: false,
          front: (topRight - topLeft).cross(const ZVector.only(z: height)),
          fill: true,
          stroke: 2,
          color: side,
          backfaceColor: inside,
        ),
      )
    ]);

    final leftZShape = ZPositioned(
      translate: const ZVector.only(z: -stroke),
      child: ZShape(
        path: [
          ZMove.vector(bottomLeft),
          ZLine.vector(topLeft),
          ZLine.vector(topLeft.copyWith(z: -height)),
          ZLine.vector(bottomLeft.copyWith(z: -height)),
        ],
        front: (bottomLeft - topLeft).cross(const ZVector.only(z: -height)),
        fill: true,
        stroke: 2,
        color: side,
        backfaceColor: inside,
      ),
    );

    final bottomZShape = ZPositioned(
      translate: const ZVector.only(z: -stroke),
      child: ZShape(
        path: [
          ZMove.vector(bottomRight),
          ZLine.vector(bottomLeft),
          ZLine.vector(bottomLeft.copyWith(z: -height)),
          ZLine.vector(bottomRight.copyWith(z: -height)),
        ],
        front: (bottomLeft - bottomRight).cross(const ZVector.only(z: height)),

        fill: true,
        stroke: 2,
        color: side,
        backfaceColor: inside,
        //rotate: ZVector.only(x: -tau / 4),
      ),
    );
    final rightZShape = ZPositioned(
      translate: const ZVector.only(z: -stroke),
      child: ZShape(
        path: [
          ZMove.vector(bottomRight),
          ZLine.vector(topRight),
          ZLine.vector(topRight.copyWith(z: -height)),
          ZLine.vector(bottomRight.copyWith(z: -height)),
        ],
        front: (bottomRight - topRight).cross(const ZVector.only(z: height)).unit(),
        fill: true,
        stroke: 2,
        color: side,
        backfaceColor: inside,
      ),
    );
    return ZGroup(
      children: [
        frontZShape,
        rightZShape,
        leftZShape,
        topZShape,
        bottomZShape,
      ],
    );
  }
}

class MiddleZLine extends StatelessWidget {
  final ZVector translate;
  final ZVector bottomLeft;
  final ZVector bottomRight;
  final ZVector topRight;
  final ZVector topLeft;
  final double z;
  final Color front;
  final Color inside;
  final Color side;

  const MiddleZLine({
    super.key,
    this.translate = ZVector.zero,
    required this.bottomLeft,
    required this.bottomRight,
    required this.topRight,
    required this.topLeft,
    required this.z,
    required this.front,
    required this.inside,
    required this.side,
  });

  @override
  Widget build(BuildContext context) {
    const stroke = 0.0;
    const height = 4.0;

    final frontZShape = ZShape(path: [
      ZMove.vector(bottomLeft),
      ZLine.vector(bottomRight),
      ZLine.vector(topRight),
      ZLine.vector(topLeft),
    ], color: front, fill: true, stroke: 2);

    final topZShape = ZPositioned(
      translate: const ZVector.only(z: -stroke),
      child: ZShape(
        path: [
          ZMove.vector(topRight),
          ZLine.vector(topLeft),
          ZLine.vector(topLeft.copyWith(z: -height)),
          ZLine.vector(topRight.copyWith(z: -height)),
        ],
        front: (topRight - topLeft).cross(const ZVector.only(z: height)),
        fill: true,
        stroke: 2,
        color: side,
        backfaceColor: inside,
      ),
    );

    final leftZShape = ZPositioned(
      translate: const ZVector.only(z: -stroke),
      child: ZShape(
        path: [
          ZMove.vector(bottomLeft),
          ZLine.vector(topLeft),
          ZLine.vector(topLeft.copyWith(z: -height)),
          ZLine.vector(bottomLeft.copyWith(z: -height)),
        ],
        front: (bottomLeft - topLeft).cross(const ZVector.only(z: -height)),
        fill: true,
        stroke: 2,
        color: side,
        backfaceColor: inside,
      ),
    );

    final bottomZShape = ZPositioned(
      translate: const ZVector.only(z: -stroke),
      child: ZShape(
        path: [
          ZMove.vector(bottomRight),
          ZLine.vector(bottomLeft),
          ZLine.vector(bottomLeft.copyWith(z: -height)),
          ZLine.vector(bottomRight.copyWith(z: -height)),
        ],
        front: (bottomLeft - bottomRight).cross(const ZVector.only(z: height)),

        fill: true,
        stroke: 2,
        color: side,
        backfaceColor: inside,
        //rotate: ZVector.only(x: -tau / 4),
      ),
    );

    final rightZShape = ZPositioned(
      translate: const ZVector.only(z: -stroke),
      child: ZShape(
        path: [
          ZMove.vector(bottomRight),
          ZLine.vector(topRight),
          ZLine.vector(topRight.copyWith(z: -height)),
          ZLine.vector(bottomRight.copyWith(z: -height)),
        ],
        front: (bottomRight - topRight).cross(const ZVector.only(z: height)).unit(),
        fill: true,
        stroke: 2,
        color: side,
        backfaceColor: inside,
      ),
    );
    return ZGroup(
      children: [
        frontZShape,
        rightZShape,
        leftZShape,
        topZShape,
        //  bottomZShape,
      ],
    );
  }
}

class BottomZLine extends StatelessWidget {
  final ZVector translate;
  final ZVector bottomLeft;
  final ZVector bottomRight;
  final ZVector topRight;
  final ZVector topLeft;
  final double z;
  final Color front;
  final Color inside;
  final Color side;
  final Color back;
  final ZVector middleRight;

  const BottomZLine({
    super.key,
    this.translate = ZVector.zero,
    required this.middleRight,
    required this.back,
    required this.bottomLeft,
    required this.bottomRight,
    required this.topRight,
    required this.topLeft,
    required this.z,
    required this.front,
    required this.inside,
    required this.side,
  });

  @override
  Widget build(BuildContext context) {
    const stroke = 0.0;
    const height = 4.0;

    final frontZShape = ZShape(path: [
      ZMove.vector(bottomLeft),
      ZLine.vector(bottomRight),
      ZLine.vector(topRight),
      ZLine.vector(topLeft),
    ], color: front, backfaceColor: back, fill: true, stroke: 2);

    final topZShape = ZPositioned(
      translate: const ZVector.only(z: -stroke),
      child: ZShape(
        path: [
          ZMove.vector(topRight),
          ZLine.vector(topLeft),
          ZLine.vector(topLeft.copyWith(z: -height)),
          ZLine.vector(topRight.copyWith(z: -height)),
        ],
        front: (topRight - topLeft).cross(const ZVector.only(z: height)),
        fill: true,
        stroke: 2,
        color: side,
        backfaceColor: inside,
      ),
    );

    final leftZShape = ZPositioned(
      translate: const ZVector.only(z: -stroke),
      child: ZShape(
        path: [
          ZMove.vector(bottomLeft),
          ZLine.vector(topLeft),
          ZLine.vector(topLeft.copyWith(z: -height)),
          ZLine.vector(bottomLeft.copyWith(z: -height)),
        ],
        front: (bottomLeft - topLeft).cross(const ZVector.only(z: -height)),
        fill: true,
        stroke: 2,
        color: side,
        backfaceColor: inside,
      ),
    );

    final bottomZShape = ZPositioned(
      translate: const ZVector.only(z: -stroke),
      child: ZShape(
        path: [
          ZMove.vector(bottomRight),
          ZLine.vector(bottomLeft),
          ZLine.vector(bottomLeft.copyWith(z: -height)),
          ZLine.vector(bottomRight.copyWith(z: -height)),
        ],
        front: (bottomLeft - bottomRight).cross(const ZVector.only(z: height)),

        fill: true,
        stroke: 2,
        color: side,
        backfaceColor: inside,
        //rotate: ZVector.only(x: -tau / 4),
      ),
    );
    final rightZShape = ZPositioned(
      translate: const ZVector.only(z: -stroke),
      child: ZShape(
        path: [
          ZMove.vector(bottomRight),
          ZLine.vector(middleRight),
          ZLine.vector(middleRight.copyWith(z: -height)),
          ZLine.vector(bottomRight.copyWith(z: -height)),
        ],
        front: (bottomRight - middleRight).cross(const ZVector.only(z: height)).unit(),
        fill: true,
        stroke: 2,
        color: side,
        backfaceColor: inside,
      ),
    );

    final middleZShape = ZPositioned(
      translate: const ZVector.only(z: -stroke - height * 0.1),
      child: ZShape(
        path: [
          ZMove.vector(middleRight),
          ZLine.vector(topLeft),
          ZLine.vector(topLeft.copyWith(z: -height * 0.9)),
          ZLine.vector(middleRight.copyWith(z: -height * 0.9)),
        ],
        front: (topLeft - middleRight).cross(const ZVector.only(z: height)).unit(),
        fill: true,
        stroke: 2,
        color: inside,
        backfaceColor: inside,
      ),
    );
    return ZGroup(
      children: [
        frontZShape,
        rightZShape,
        leftZShape,
        topZShape,
        //middleZShape,
        bottomZShape,
      ],
    );
  }
}
