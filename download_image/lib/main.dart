import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

void main() {
  runApp(const MyApp());
}

List listImage = [
  "https://i.ibb.co/K76D7h8/christmas-30.jpg",
  "https://i.ibb.co/RBYBbhR/christmas-35.jpg",
  "https://i.ibb.co/W0NYjkF/3.jpg",
  "https://i.ibb.co/Qnr4C7J/5.jpg",
  "https://i.ibb.co/jGQWBPV/3.jpg",
  "https://i.ibb.co/DrGc3vc/car-s1-13.jpg",
  "https://i.ibb.co/3WWtz5f/car-s1-25.jpg",
  "https://i.ibb.co/YR3jGq1/lake-s1-9.jpg",
  "https://i.ibb.co/sFSR5xh/mountain-s1-28.jpg"
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            onPageChanged: (value) => currentIndex = value,
            itemCount: listImage.length,
            itemBuilder: (context, index) => Image.network(
              listImage[index],
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Container(
              alignment: const Alignment(0, 1),
              child: TextButton(
                  onPressed: () async {
                    await GallerySaver.saveImage(listImage[currentIndex], albumName: "Test download");
                  },
                  child: const Text(
                    "Download",
                  )),
            ),
          )
        ],
      ),
    );
  }
}
