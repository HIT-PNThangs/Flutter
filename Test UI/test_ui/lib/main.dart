import 'package:flutter/material.dart';

void main() {
  runApp(const MyHomePage());
}

class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.blue;

    Path path = Path();

    // Path 1 Fill
    path.moveTo(size.width * 0.2, size.height * 0.08);
    path.cubicTo(
      size.width * 0.17,
      size.height * 0.08,
      size.width * 0.15,
      size.height * 0.12,
      size.width * 0.15,
      size.height * 0.18,
    );

    path.lineTo(size.width * 0.15, size.height * 0.38);
    path.lineTo(size.width * 0.08, size.height * 0.48);
    path.lineTo(size.width * 0.15, size.height * 0.58);
    path.lineTo(size.width * 0.15, size.height * 0.78);

    path.cubicTo(
      size.width * 0.15,
      size.height * 0.84,
      size.width * 0.17,
      size.height * 0.88,
      size.width * 0.2,
      size.height * 0.88,
    );

    path.lineTo(size.width * 0.89, size.height * 0.88);
    path.cubicTo(
      size.width * 0.92,
      size.height * 0.88,
      size.width * 0.94,
      size.height * 0.84,
      size.width * 0.94,
      size.height * 0.78,
    );

    path.lineTo(size.width * 0.94, size.height * 0.18);
    path.cubicTo(
      size.width * 0.94,
      size.height * 0.12,
      size.width * 0.92,
      size.height * 0.08,
      size.width * 0.89,
      size.height * 0.08,
    );

    path.lineTo(size.width * 0.2, size.height * 0.08);
    path.lineTo(size.width * 0.2, size.height * 0.08);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class RectangleWidget extends StatelessWidget {
  const RectangleWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RectanglePainter(),
      child: SizedBox(
        width: 250,
        height: 150,
        child: child,
      ),
    );
  }
}

class ThermometerWidget extends StatelessWidget {
  const ThermometerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 300,
      decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFBFC9D7),
              offset: Offset(4, 4),
              blurRadius: 10,
            )
          ]),
      child: Stack(
        children: [
          Container(
            width: 14,
            height: 4,
            margin: const EdgeInsets.only(top: 30),
            decoration: const BoxDecoration(
              color: Color(0xFFB0B0B0),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
          Container(
            width: 14,
            height: 4,
            margin: const EdgeInsets.only(top: 60),
            decoration: const BoxDecoration(
              color: Color(0xFFB0B0B0),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
          Container(
            width: 14,
            height: 4,
            margin: const EdgeInsets.only(top: 90),
            decoration: const BoxDecoration(
              color: Color(0xFFB0B0B0),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
          Container(
            width: 14,
            height: 4,
            margin: const EdgeInsets.only(top: 120),
            decoration: const BoxDecoration(
              color: Color(0xFFB0B0B0),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
          Container(
            width: 14,
            height: 4,
            margin: const EdgeInsets.only(top: 150),
            decoration: const BoxDecoration(
              color: Color(0xFFB0B0B0),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 14,
              height: 4,
              margin: const EdgeInsets.only(top: 38),
              decoration: const BoxDecoration(
                color: Color(0xFFB0B0B0),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 14,
              height: 4,
              margin: const EdgeInsets.only(top: 68),
              decoration: const BoxDecoration(
                color: Color(0xFFB0B0B0),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 14,
              height: 4,
              margin: const EdgeInsets.only(top: 98),
              decoration: const BoxDecoration(
                color: Color(0xFFB0B0B0),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 14,
              height: 4,
              margin: const EdgeInsets.only(top: 128),
              decoration: const BoxDecoration(
                color: Color(0xFFB0B0B0),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 14,
              height: 4,
              margin: const EdgeInsets.only(top: 158),
              decoration: const BoxDecoration(
                color: Color(0xFFB0B0B0),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: 80,
                  margin: const EdgeInsets.only(top: 160),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFBFC9D7),
                        blurRadius: 10,
                        offset: Offset(2, 3),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 40,
                  height: 200,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFBFC9D7),
                        blurRadius: 10,
                        offset: Offset(2, 3),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  margin: const EdgeInsets.only(top: 160),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 30,
                  height: 160,
                  margin: const EdgeInsets.only(top: 80),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  margin: const EdgeInsets.only(top: 160),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF5F5F5),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AnimatedTextField extends StatefulWidget {
  const AnimatedTextField({super.key});

  @override
  _AnimatedTextFieldState createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController _textEditingController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _textEditingController = TextEditingController();
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _textEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            labelText: 'Enter Text',
            labelStyle: TextStyle(
              fontSize: 20.0 * _animation.value,
              color: Colors.grey[400],
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.status == AnimationStatus.completed) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: const Text('My Home Page'),
        ),
        body: const Center(
          child: AnimatedTextField(),
        ),
      ),
    );
  }
}
