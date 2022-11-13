import 'package:get/get.dart';
import 'package:home_screen_test/app/binding/home_binding.dart';
import 'package:home_screen_test/app/binding/intro_binding.dart';
import 'package:home_screen_test/app/ui/screen/intro_screen.dart';

import '../binding/splash_binding.dart';
import '../ui/screen/home_screen.dart';
import '../ui/screen/splash_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoute.splash_screen, page: () => const SplashScreen(), binding: SplashBinding()),
    GetPage(name: AppRoute.intro_screen, page: () => const IntroScreen(), binding: IntroBinding()),
    GetPage(name: AppRoute.home_screen, page: () => HomeScreen(), binding: HomeBinding()),
  ];
}

class AppRoute {
  static const String splash_screen = '/splash_screen';
  static const String home_screen = '/home_screen';
  static const String intro_screen = '/intro_screen';
}
