import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tutorial - googleflutter.com'),
        backgroundColor: const Color(0xFF444444),
      ),
      body: ListView(children: <Widget>[
        const Text(
          'Canvas',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, height: 2),
        ),
        SizedBox(
          width: 400,
          height: 400,
          child: CustomPaint(
            painter: OpenPainter(),
          ),
        ),
      ]),
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
