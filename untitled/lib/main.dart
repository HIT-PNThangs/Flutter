import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String buttonName = 'Click';
    return MaterialApp(
      debugShowCheckedModeBanner: false, // bỏ dấu debugging khi chạy app
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Title'),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                buttonName = 'Clicked';
              },
              child: Text(buttonName))
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
                label: 'Setting',
                icon: Icon(Icons.settings)),
          ],
        ),
      )
    );
  }
}
