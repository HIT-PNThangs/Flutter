import 'package:get/get.dart';

import 'binding/splash_binding.dart';
import 'ui/splash_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoute.splash_screen,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
  ];
}

class AppRoute {
  static const String splash_screen = '/splash_screen';
}
