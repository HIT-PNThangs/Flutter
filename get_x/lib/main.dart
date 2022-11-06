import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  var cnt = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Count App"),
      ),
      body: Center(
        child: Obx(
          () => Text(
            "$cnt",
            style: const TextStyle(fontSize: 50),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => cnt += 1,
        child: const Icon(Icons.add),
      ),
    );
  }
}
