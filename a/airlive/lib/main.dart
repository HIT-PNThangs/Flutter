import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app/binding/app_binding.dart';
import 'app/res/font/app_fonts.dart';
import 'app/route/app_pages.dart';
import 'app/ui/loading/easy_loading.dart';
import 'util/app_constant.dart';

void main() async {
  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(testDeviceIds: ['F5872185F6EA4E125B70463225E53D98']));

  await AppLovinMAX.initialize(AppConstant.appLovinToken);

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
        builder: EasyLoading.init(),
        theme: ThemeData(brightness: Brightness.dark, fontFamily: AppFonts.robotoRegular));
  }
}
