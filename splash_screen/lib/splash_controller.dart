import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  late BuildContext context;
  RxString version = ''.obs;
  String _isFirstTimeOpenApp = '1';

  @override
  void onReady() async {
    super.onReady();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
    final prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('languageCode');
    _isFirstTimeOpenApp = prefs.getString('firstOpenCheck') ?? '1';
    prefs.setString('firstOpenCheck', '0');
    String stringDataListUser = prefs.getString('stringDataListUser') ?? '';
    String selectedUserId = prefs.getString('selectedUserId') ?? '';
    // _initUser(stringDataListUser, selectedUserId);
    // Get.find<AppController>().updateLocale(AppConstant.availableLocales[int.tryParse(language ?? '1') ?? 1]);
    // Get.find<AppController>().updateDailyNumberCount(prefs.getString('dailyNumberCount'));
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
    _toNextScreen(language);
  }

  _toNextScreen(String? language) async {
    // if (language == null) {
    //   await Get.toNamed(AppRoute.languageScreen);
    // }

    // ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    //
    // if (connectivityResult == ConnectivityResult.none) {
    //   showDialog(
    //       context: context,
    //       builder: (buildContext) {
    //         return AlertDialog(
    //           title: Text(StringConstants.noNetTitle.tr),
    //           content: Text(StringConstants.noNetContent.tr),
    //           actions: [
    //             AppTouchable(
    //               onPressed: () {
    //                 Get.back();
    //                 _toNextScreen(language);
    //               },
    //               padding: EdgeInsets.symmetric(vertical: 4.0.sp, horizontal: 8.0.sp),
    //               child: Text(
    //                 StringConstants.retry.tr,
    //                 style: TextStyle(
    //                   color: AppColor.black.withOpacity(0.6),
    //                   fontSize: 16.0.sp,
    //                   fontWeight: FontWeight.w500,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         );
    //       });
    // } else {
    //   Get.offAndToNamed(_isFirstTimeOpenApp == '1' ? AppRoute.introScreen : AppRoute.homeScreen);
    // }
  }

  // _initUser(String stringDataListUser, String selectedUserId) async {
  //   if (stringDataListUser.isEmpty) {
  //     Get.find<AppController>().updateSelectedUser(UserModel());
  //     return;
  //   } else {
  //     List<UserModel> listUsers = (json.decode(stringDataListUser) as List?)
  //         ?.map((dynamic e) => UserModel.fromJson(e as Map<String, dynamic>))
  //         .toList() ??
  //         [];
  //     Get.find<AppController>().listUsers.value = listUsers;
  //     if (selectedUserId.isNotEmpty) {
  //       Get.find<AppController>()
  //           .updateSelectedUser(listUsers.firstWhere((user) => user.id == selectedUserId, orElse: () => UserModel()));
  //     }
  //   }
  // }
}
