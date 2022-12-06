import 'package:flutter/material.dart';
import 'package:my_image/app/my_image/set.dart';

import 'app/my_image/image/image.dart';
import 'helpers/mock_image_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Set Demo',
      theme: ThemeData(),
      home: MyImagePage(
        sets: <MySet>[
          MySet.blurHash('LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
          MySet.circleAvatar(
            backgroundColor: Colors.red,
            text: const Text(
              "M",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          MySet.circularIndicatorAndIcon(),
          MySet.circularIndicatorAndIcon(showProgress: true),
        ],
      ),
    );
  }
}

class MyImagePage extends StatelessWidget {
  final List<MySet> sets;

  const MyImagePage({Key? key, required this.sets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Demo'),
      ),
      body: ListView(children: sets.map((element) => _row(element)).toList()),
    );
  }

  Widget _row(MySet mySet) {
    return Row(
      children: <Widget>[
        Expanded(
          child: AspectRatio(
            aspectRatio: 269 / 173,
            child: MyImage.fromSet(
              image: MockImageProvider(useCase: TestUseCase.loadAndFail),
              mySet: mySet,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 269 / 173,
            child: MyImage.fromSet(
              image: MockImageProvider(useCase: TestUseCase.loadAndSuccess),
              mySet: mySet,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
