import 'package:flutter/material.dart';

import 'app/my_image/errors.dart';
import 'app/my_image/image/image.dart';
import 'app/my_image/placeholders.dart';
import 'app/my_image/set.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Demo',
      theme: ThemeData(),
      home: const MyImagePage(),
    );
  }
}

class MyImagePage extends StatelessWidget {
  const MyImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Demo'),
      ),
      body: ListView(
        children: [
          _customImage(),
          const SizedBox(height: 16),
          _simpleBlur(),
          const SizedBox(height: 16),
          _circleAvatar(),
        ],
      ),
    );
  }

  Widget _customImage() {
    return SizedBox(
      height: 150,
      child: MyImage(
        image: const NetworkImage('https://via.placeholder.com/150'),
        progressIndicatorBuilder: (context, progress) {
          double? value;
          var expectedBytes = progress?.expectedTotalBytes;
          if (progress != null && expectedBytes != null) {
            value = progress.cumulativeBytesLoaded / expectedBytes;
          }
          return CircularProgressIndicator(value: value);
        },
        errorBuilder: (context, error, stacktrace) => const Icon(Icons.error),
      ),
    );
  }

  Widget _simpleBlur() {
    return AspectRatio(
      aspectRatio: 269 / 173,
      child: MyImage(
        image: const NetworkImage('https://blurha.sh/assets/images/img1.jpg'),
        placeholderBuilder: MyPlaceholder.blurHash(
          'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
        ),
        errorBuilder: MyError.icon(color: Colors.red),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _circleAvatar() {
    return SizedBox(
      height: 75,
      child: MyImage.fromSet(
        fit: BoxFit.cover,
        image: const NetworkImage(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Macaca_nigra_self-portrait_large.jpg/1024px-Macaca_nigra_self-portrait_large.jpg',
        ),
        mySet: MySet.circleAvatar(
          backgroundColor: Colors.red,
          text: const Text("M"),
        ),
      ),
    );
  }
}
