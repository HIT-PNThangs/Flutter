import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'app/src/widget/container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    const percentage = 50.0;
    return Stack(
      children: <Widget>[
        Align(
          child: Neumorphic(
            // boxShape: const NeumorphicBoxShape.circle(),
            padding: const EdgeInsets.all(80),
            style: NeumorphicStyle(
              depth: NeumorphicTheme.embossDepth(context),
            ),
            child: CustomPaint(
              painter: NeuProgressPainter(
                circleWidth: 20,
                completedPercentage: percentage,
                defaultCircleColor: Colors.transparent,
              ),
              child: const Center(),
            ),
          ),
        ),
        Align(
          child: Neumorphic(
            // boxShape: const NeumorphicBoxShape.circle(),
            padding: const EdgeInsets.all(80),
            style: NeumorphicStyle(
              color: Colors.white,
              depth: NeumorphicTheme.depth(context),
            ),
          ),
        ),
      ],
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = const Color(0xff71BF0D)
      ..style = PaintingStyle.fill;

    double radius = 100.0;
    canvas.translate(size.width / 2, size.height / 2);
    Offset center = const Offset(0.0, 0.0);
    // draw shadow first
    Path oval = Path()..addOval(Rect.fromCircle(center: center, radius: radius + 10));
    Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50);
    canvas.drawPath(oval, shadowPaint);
    // draw circle
    Paint thumbPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    // canvas.drawCircle(center, radius, thumbPaint);
    //
    // var paint2 = Paint()
    //   ..color = const Color(0xffffffff)
    //   ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 100, paint1);
    canvas.drawCircle(center, 80, thumbPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class NeuProgressPainter extends CustomPainter {
  //
  Color defaultCircleColor;
  Color? percentageCompletedCircleColor;
  double completedPercentage;
  double circleWidth;

  NeuProgressPainter(
      {required this.defaultCircleColor,
      this.percentageCompletedCircleColor,
      required this.completedPercentage,
      required this.circleWidth});

  getPaint(Color color) {
    return Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint defaultCirclePaint = getPaint(defaultCircleColor);

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2);
    Rect boundingSquare = Rect.fromCircle(center: center, radius: radius);

    paint(
      List<Color> colors,
    ) {
      final Gradient gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
        colors: colors,
      );

      return Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = circleWidth
        ..shader = gradient.createShader(boundingSquare);
    }

    canvas.drawCircle(center, radius, defaultCirclePaint);

    double arcAngle = 2 * math.pi * (completedPercentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      arcAngle,
      false,
      paint(
        [
          const Color(0xFF71BF0D),
          const Color(0xFFB8BEBA),
          const Color(0xFFFFFFFF),
        ],
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter painter) {
    return true;
  }
}
