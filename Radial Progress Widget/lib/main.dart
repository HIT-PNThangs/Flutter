import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static double percentage = 120.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RadialProgressWidget(
        percentage: percentage,
      ),
    );
  }
}

class RadialProgressWidget extends StatefulWidget {
  final double percentage;

  const RadialProgressWidget({Key? key, required this.percentage}) : super(key: key);

  @override
  State<RadialProgressWidget> createState() => _RadialProgressWidgetState();
}

class _RadialProgressWidgetState extends State<RadialProgressWidget> {
  var value = 0.0;
  final speed = 0.5;

  late Timer timer;

  final List<Particle> particles =
      List<Particle>.generate(200, (index) => Particle(radiusSize + thickness / 2.0));

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
      var v = value;

      if (v <= widget.percentage) {
        v += speed;
      } else {
        for (var value in particles) {
          setState(() {
            value.update();
          });
        }

        debugPrint("Particle Update");
      }

      setState(() {
        value = v;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RadialProgressPainter(value, particles),
      child: Container(),
    );
  }
}

const double radiusSize = 100.0;
const double thickness = 10.0;
const TextStyle textStyle = TextStyle(
  color: Colors.red,
  fontSize: 50,
  fontWeight: FontWeight.bold,
);

class Particle {
  double orbit;

  late double originalOrbit;
  late double theta;
  late double opacity;
  late Color color;

  Particle(this.orbit) {
    originalOrbit = orbit;
    theta = getRandomRange(0.0, 360.0) * pi / 180;
    opacity = getRandomRange(0.3, 1);
    color = Colors.white;
  }

  void update() {
    orbit += 0.1;
    opacity -= 0.0025;

    if(opacity <= 0.0) {
      orbit = originalOrbit;
      opacity = getRandomRange(0.1, 1.0);
    }
  }
}

double getRandomRange(double begin, double end) {
  return Random().nextDouble() * (end - begin) + begin;
}

Offset polarToCartesian(double r, double theta) {
  final dx = r * cos(theta);
  final dy = r * sin(theta);

  return Offset(dx, dy);
}

class RadialProgressPainter extends CustomPainter {
  final double percentage;
  final List<Particle> particles;

  RadialProgressPainter(this.percentage, this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Colors.grey);

    final c = Offset(size.width / 2.0, size.height / 2.0);
    final rect = Rect.fromCenter(center: c, width: 2 * radiusSize, height: 2 * radiusSize);

    // canvas.drawRect(rect, Paint()..color = Colors.black26);
    drawGuide(canvas, c, radiusSize);
    drawArc(canvas, rect);
    drawTextCentered(canvas, c, "${percentage.toInt()}", textStyle, radiusSize * 2 * 0.8);
    drawParticle(canvas, c);
  }

  void drawGuide(Canvas canvas, Offset c, double radius) {
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(c, radius, paint);
  }

  void drawArc(Canvas canvas, Rect rect) {
    const startAngle = -90 * pi / 180;
    final sweepAngle = percentage * pi / 180;
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  Size drawTextCentered(
      Canvas canvas, Offset position, String text, TextStyle textStyle, double maxWidth) {
    final tp = measureText(text, textStyle, maxWidth, TextAlign.center);

    // tp.paint(canvas, position);
    tp.paint(canvas, position + Offset(-tp.width / 2.0, -tp.height / 2.0));
    return tp.size;
  }

  TextPainter measureText(String text, TextStyle textStyle, double maxWidth, TextAlign textAlign) {
    final span = TextSpan(text: text, style: textStyle);
    final tp = TextPainter(
      text: span,
      textAlign: textAlign,
      textDirection: TextDirection.ltr,
    );
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }

  void drawParticle(Canvas canvas, Offset offset) {
    for (var value in particles) {
      final Offset c = polarToCartesian(value.orbit, value.theta) + offset;
      final paint = Paint()..color = value.color.withOpacity(value.opacity);

      canvas.drawCircle(c, 1.0, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
