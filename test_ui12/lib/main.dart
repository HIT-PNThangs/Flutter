import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: MyPageControllers(),
        ),
      ),
    );
  }
}

class MyPageControllers extends StatefulWidget {
  const MyPageControllers({super.key});

  @override
  _MyPageControllersState createState() => _MyPageControllersState();
}

class _MyPageControllersState extends State<MyPageControllers> {
  late PageController _controller1;
  late PageController _controller2;
  int manualController = -1;

  Widget _itemBuilder(BuildContext context, int index) => Container(
        color: Colors.primaries[index % Colors.primaries.length],
        child: Center(
          child: Text(
            index.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 60),
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    _controller1 = PageController(viewportFraction: 0.8);
    _controller2 = PageController(viewportFraction: 0.5);

    _controller1.addListener(() {
      if (manualController == 1) {
        _controller2.jumpTo(_controller1.offset);
      }
    });

    _controller2.addListener(() {
      if (manualController == 2) {
        _controller1.jumpTo(_controller2.offset);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTapDown: (tapDownDetails) {
              manualController = 1;
              setState(() {});
            },
            onTapUp: (tapUpDetails) {
              manualController = -1;
              setState(() {});
            },
            child: PageView.builder(
              controller: _controller1,
              itemBuilder: _itemBuilder,
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Expanded(
          child: GestureDetector(
            onTapDown: (tapDownDetails) {
              manualController = 2;
              setState(() {});
            },
            onTapUp: (tapUpDetails) {
              manualController = -1;
              setState(() {});
            },
            child: PageView.builder(
              controller: _controller2,
              itemBuilder: _itemBuilder,
            ),
          ),
        ),
      ],
    );
  }
}
