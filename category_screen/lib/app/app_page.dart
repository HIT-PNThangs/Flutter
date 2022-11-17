import 'package:category_screen/app/binding/category_binding.dart';
import 'package:category_screen/app/binding/splash_binding.dart';
import 'package:category_screen/app/ui/category_screen.dart';
import 'package:category_screen/app/ui/splash_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoute.splash_screen, page: () =>  const SplashScreen(), binding: SplashBinding()),
    GetPage(name: AppRoute.category_screen, page: () => CategoryScreen(), binding: CategoryBinding()),
  ];
}

class AppRoute {
  static const String category_screen = '/category_screen';
  static const String splash_screen = '/splash_screen';
}
