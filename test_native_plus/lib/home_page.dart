import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String nativeAdId = "ca-app-pub-3940256099942544/2247696110";

  NativeAd? nativeAd;
  bool isNativeAdLoaded = false;

  NativeAd? nativeAd1;
  bool isNativeAdLoaded1 = false;

  NativeAd? nativeAd2;
  bool isNativeAdLoaded2 = false;

  NativeAd? nativeAd3;
  bool isNativeAdLoaded3 = false;

  NativeAd? smallNativeAd;
  bool isSmallNativeAdLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loadNativeAd();
    loadNativeAd1();
    loadNativeAd2();
    loadNativeAd3();
    loadSmallNativeAd();
  }

  void loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: nativeAdId,
      factoryId: "listTileMedium",
      listener: NativeAdListener(onAdLoaded: (ad) {
        setState(() {
          isNativeAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        nativeAd!.dispose();
      }),
      request: const AdRequest(),
    );

    nativeAd!.load();
  }

  void loadNativeAd1() {
    nativeAd1 = NativeAd(
      adUnitId: nativeAdId,
      factoryId: "listTileMedium",
      listener: NativeAdListener(onAdLoaded: (ad) {
        setState(() {
          isNativeAdLoaded1 = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        nativeAd1!.dispose();
      }),
      request: const AdRequest(),
    );

    nativeAd1!.load();
  }

  void loadNativeAd2() {
    nativeAd2 = NativeAd(
      adUnitId: nativeAdId,
      factoryId: "listTileMedium",
      listener: NativeAdListener(onAdLoaded: (ad) {
        setState(() {
          isNativeAdLoaded2 = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        nativeAd2!.dispose();
      }),
      request: const AdRequest(),
    );

    nativeAd2!.load();
  }

  void loadNativeAd3() {
    nativeAd3 = NativeAd(
      adUnitId: nativeAdId,
      factoryId: "listTileMedium",
      listener: NativeAdListener(onAdLoaded: (ad) {
        setState(() {
          isNativeAdLoaded3 = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        nativeAd3!.dispose();
      }),
      request: const AdRequest(),
    );

    nativeAd3!.load();
  }

  void loadSmallNativeAd() {
    smallNativeAd = NativeAd(
      adUnitId: nativeAdId,
      factoryId: "listTile",
      listener: NativeAdListener(onAdLoaded: (ad) {
        setState(() {
          isSmallNativeAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        smallNativeAd!.dispose();
      }),
      request: const AdRequest(),
    );

    smallNativeAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: [
          isNativeAdLoaded
              ? Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: 265,
                  child: AdWidget(
                    ad: nativeAd!,
                  ),
                )
              : const SizedBox(),
          isNativeAdLoaded1
              ? Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: 265,
                  child: AdWidget(
                    ad: nativeAd1!,
                  ),
                )
              : const SizedBox(),
          const Spacer(),
          isNativeAdLoaded2
              ? Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: 265,
                  child: AdWidget(
                    ad: nativeAd2!,
                  ),
                )
              : const SizedBox(),
          const Spacer(),
          isNativeAdLoaded3
              ? Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            height: 265,
            child: AdWidget(
              ad: nativeAd3!,
            ),
          )
              : const SizedBox(),
          const Spacer(),
          isSmallNativeAdLoaded
              ? Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: 140,
                  child: AdWidget(
                    ad: smallNativeAd!,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    ));
  }
}
