import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/binding/app_binding.dart';
import 'app/route/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: AppBinding(),
        initialRoute: AppRoute.splash_screen,
        getPages: AppPages.pages,
        theme: ThemeData(brightness: Brightness.dark));
  }
}
