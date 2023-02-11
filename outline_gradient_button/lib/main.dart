import 'package:flutter/material.dart';

import 'outline_gradient.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> _rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: _rootScaffoldMessengerKey,
      home: Scaffold(
        appBar: AppBar(title: const Text('Outline gradient buttons demo')),
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(48),
            child: Wrap(
              spacing: 24,
              runSpacing: 48,
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: _buildChildren(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChildren() {
    return [
      OutlineGradientButton(
        gradient: const LinearGradient(
          colors: [Colors.purple, Colors.pink],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        strokeWidth: 4,
        child: const Text('WOW'),
      ),
      OutlineGradientButton(
        gradient: const LinearGradient(colors: [Colors.pink, Colors.purple]),
        strokeWidth: 4,
        radius: const Radius.circular(8),
        child: const Text('TEXT'),
      ),
      OutlineGradientButton(
        gradient: const LinearGradient(
          stops: [0, 0.5, 0.5, 1],
          colors: [Colors.green, Colors.green, Colors.red, Colors.red],
        ),
        strokeWidth: 4,
        corners: const Corners(topLeft: Radius.elliptical(16, 14), bottomRight: Radius.circular(6)),
        child: const Text('OMG'),
      ),
      OutlineGradientButton(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.black],
          begin: Alignment(-1, -1),
          end: Alignment(2, 2),
        ),
        strokeWidth: 4,
        padding: EdgeInsets.zero,
        radius: const Radius.circular(26),
        child: SizedBox(
          width: 52,
          height: 52,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.opacity, color: Colors.grey, size: 24),
              Text('TEXT', style: TextStyle(fontSize: 9)),
            ],
          ),
        ),
      ),
      OutlineGradientButton(
        gradient: LinearGradient(
          colors: List.generate(360, (h) => HSLColor.fromAHSL(1, h.toDouble(), 1, 0.5).toColor()),
        ),
        strokeWidth: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        radius: const Radius.circular(8),
        child: const Text('Linear gradient', style: TextStyle(color: Colors.black, fontSize: 10)),
      ),
      OutlineGradientButton(
        gradient: SweepGradient(
          colors: List.generate(360, (h) => HSLColor.fromAHSL(1, h.toDouble(), 1, 0.5).toColor()),
        ),
        strokeWidth: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        radius: const Radius.circular(8),
        child: const Text('Sweep gradient', style: TextStyle(color: Colors.black, fontSize: 10)),
      ),
      OutlineGradientButton(
        gradient: const LinearGradient(colors: [Colors.greenAccent, Colors.yellow]),
        strokeWidth: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        corners: const Corners(topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
        backgroundColor: Colors.lightBlue,
        elevation: 4,
        inkWell: true,
        onTap: () => showSnack('onTap'),
        onDoubleTap: () => showSnack('onDoubleTap'),
        onLongPress: () => showSnack('onLongPress'),
        child: const Text('With background color and elevation', style: TextStyle(color: Colors.white, fontSize: 12)),
      ),
      OutlineGradientButton(
        gradient: const LinearGradient(colors: [Colors.white, Colors.black]),
        width: 100,
        height: 120,
        strokeWidth: 2,
        padding: const EdgeInsets.all(2),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.white, Colors.black], begin: Alignment(1, 1), end: Alignment(-3, -3))),
          ),
        ),
      )
    ];
  }

  void showSnack(String text) {
    _rootScaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    _rootScaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text(text)));
  }
}
