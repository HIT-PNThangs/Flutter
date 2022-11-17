import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

List<dynamic> list = [
  "lib/images/image1.jpg",
  "lib/images/image2.jpg",
  "lib/images/image3.jpg",
  "lib/images/image4.jpg",
  "lib/images/image5.jpg",
  "lib/images/image6.jpg",
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
  // final LoopPageController thumbnailController =
  //     LoopPageController(viewportFraction: 0.75);
  //
  // final LoopPageController imageController = LoopPageController();

  int currentIndex = 0;

  final PageController thumbnailController =
      PageController(viewportFraction: 0.75);
  final PageController imageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: const Alignment(1, 1),
        children: [
          PageView.builder(
              controller: imageController,
              itemCount: list.length,
              onPageChanged: (value) => {
                    setState(() {
                      currentIndex = value;
                    })
                  },
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Image.asset(list[index],
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover);
              }),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Image.asset(list[index], fit: BoxFit.cover);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
