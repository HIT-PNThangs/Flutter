import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasPermissions = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchPermissions();
  }

  void fetchPermissions() {
    Permission.locationWhenInUse.status.then((status) => {
      if (mounted) {
        setState(() {
          hasPermissions = (status == PermissionStatus.granted);
        })
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Builder(
          builder: (context) {
            if (hasPermissions) {
              return buildCompass();
            } else {
              return buildPermissionSheet();
            }
          },
        ),
      ),
    );
  }

  // Compass widget
  Widget buildCompass() {
    return Material();
  }

  // Permission Sheet widget
  Widget buildPermissionSheet() {
    return Center(
      child: ElevatedButton(
        child: const Text("Request Permission"),
        onPressed: () => {
          Permission.locationWhenInUse
              .request()
              .then((value) => {fetchPermissions()})
        },
      ),
    );
  }
}
