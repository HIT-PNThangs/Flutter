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

  NativeAd? smallNativeAd;
  bool isSmallNativeAdLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadNativeAd();

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
        appBar: AppBar(
          title: const Text("Native Ad"),
        ),
        body: Column(
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
        ));
  }
}
