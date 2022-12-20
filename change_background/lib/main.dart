import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

List listImages = [
  "lib/app/image/background1.png",
  "lib/app/image/background2.png",
  "lib/app/image/background3.png",
  "lib/app/image/background4.png",
  "lib/app/image/background5.png",
  "lib/app/image/background6.png",
  "lib/app/image/background7.png",
  "lib/app/image/background8.png",
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(listImages[index]),
            fit: BoxFit.cover
          )
        ),
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  index = (index + 1) % listImages.length;
                });
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Lottie.asset("lib/app/image/arrow_right.json", width: 40.0, height: 40.0),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  index = (index - 1 + listImages.length) % listImages.length;
                });
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: RotatedBox(
                    quarterTurns: 2, child: Lottie.asset("lib/app/image/arrow_right.json", width: 40.0, height: 40.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
