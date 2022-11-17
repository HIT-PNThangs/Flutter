import 'package:category_screen/app/app_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/binding/app_binding.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: AppRoute.splash_screen,
      getPages: AppPages.pages,
      theme: ThemeData(brightness: Brightness.dark)
    );
  }
}