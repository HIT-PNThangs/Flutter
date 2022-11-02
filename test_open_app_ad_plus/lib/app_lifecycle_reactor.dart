import 'package:flutter/material.dart';
import 'package:test_open_app_ad_plus/open_app_ad_manager.dart';

class AppLifecycleReactor extends WidgetsBindingObserver {
  final OpenAppAdManager appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    if (state == AppLifecycleState.resumed) {
      appOpenAdManager.showAdIfAvailable();
    }
  }
}
