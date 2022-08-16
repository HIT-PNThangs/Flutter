import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String buttonName = 'Click';
  int cnt = 1;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, // bỏ dấu debugging khi chạy app
        home: Scaffold(
          appBar: AppBar(
            title: const Text('App Title'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (cnt % 2 == 1) {
                      buttonName = 'Clicked';
                    } else {
                      buttonName = 'Click';
                    }
                    cnt += 1;
                  });
                },
                child: Text(buttonName)),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (cnt % 2 == 1) {
                      buttonName = 'Clicked';
                    } else {
                      buttonName = 'Click';
                    }
                    cnt += 1;
                  });
                },
                child: Text(buttonName))
          ])),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: 'Setting', icon: Icon(Icons.settings)),
            ],
            currentIndex: currentIndex,
            onTap: (int index) => {
              setState(() {
                currentIndex = index;
              })
            },
          ),
        ));
  }
}
