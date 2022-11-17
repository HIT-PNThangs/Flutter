import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';

import 'page_transformer.dart';
import 'transform_info.dart';
import 'transformer_pageview.dart';

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
      home: const HomeScreen1(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double viewportFraction = 0.8;
  late double pageOffset = 0;

  final LoopPageController controller =
      LoopPageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return LoopPageView.builder(
        controller: controller,
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
                right: 10, top: 100, bottom: 150, left: 20),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(list[index],
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover),
            ),
          );
        });
  }
}

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  @override
  Widget build(BuildContext context) {
    return TransformerPageView(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        transformer: DeepthPageTransformer(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
                right: 10, top: 100, bottom: 150, left: 20),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(list[index],
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover),
            ),
          );
        });
  }
}

class DeepthPageTransformer extends PageTransformer {
  DeepthPageTransformer() : super(reverse: true);

  @override
  Widget transform(Widget child, TransformInfo info) {
    double position = info.position;
    if (position <= 0) {
      return Opacity(
        opacity: 1.0,
        child: Transform.translate(
          offset: const Offset(0.0, 0.0),
          child: Transform.scale(
            scale: 1.0,
            child: child,
          ),
        ),
      );
    } else if (position <= 1) {
      const double MIN_SCALE = 0.75;
      // Scale the page down (between MIN_SCALE and 1)
      double scaleFactor = MIN_SCALE + (1 - MIN_SCALE) * (1 - position);

      return Opacity(
        opacity: 1.0 - position,
        child: Transform.translate(
          offset:
              Offset(0.0, -position * info.height), // info.width * -position
          child: Transform.scale(
            scale: scaleFactor,
            child: child,
          ),
        ),
      );
    }

    return child;
  }
}
