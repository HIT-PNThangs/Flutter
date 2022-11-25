import 'package:get/get.dart';


import '../binding/home_binding.dart';
import '../binding/splash_binding.dart';
import '../ui/screen/home_screen.dart';

import '../ui/screen/splash_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoute.splash_screen, page: () => const SplashScreen(), binding: SplashBinding()),
    GetPage(name: AppRoute.home_screen, page: () => HomeScreen(), binding: HomeBinding()),
  ];
}

class AppRoute {
  static const String splash_screen = '/splash_screen';
  static const String home_screen = '/home_screen';
}
