import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

List<dynamic> list = [
  "lib/images/image1.jpg",
  "lib/images/image2.jpg",
  "lib/images/image3.jpg",
  "lib/images/image4.jpg",
  "lib/images/image5.jpg",
  "lib/images/image6.jpg",
  "lib/images/image6.jpg",
  "lib/images/image5.jpg",
  "lib/images/image4.jpg",
  "lib/images/image3.jpg",
  "lib/images/image2.jpg",
  "lib/images/image1.jpg",
  "lib/images/image1.jpg",
  "lib/images/image2.jpg",
  "lib/images/image3.jpg",
  "lib/images/image4.jpg",
  "lib/images/image5.jpg",
  "lib/images/image6.jpg",
  "lib/images/image6.jpg",
  "lib/images/image5.jpg",
  "lib/images/image4.jpg",
  "lib/images/image3.jpg",
  "lib/images/image2.jpg",
  "lib/images/image1.jpg",
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 128,
          child: ListView.builder(
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(list[index], width: 64, height: 128);
            },
          ),
        ),
      ),
    );
  }
}
