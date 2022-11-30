import 'package:applovin_max/applovin_max.dart';

import '../../util/app_constant.dart';

class AddBannerAdManager {
  initializeBannerAds() {
    AppLovinMAX.createBanner(AppConstant.IDBannerAd, AdViewPosition.bottomCenter);
    AppLovinMAX.setBannerBackgroundColor(AppConstant.IDBannerAd, '#000000');
  }

  showBanner(){
    AppLovinMAX.showBanner(AppConstant.IDBannerAd);
  }

  hideBanner(){
    AppLovinMAX.hideBanner(AppConstant.IDBannerAd);
  }
}
