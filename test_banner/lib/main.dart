import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

// Create constants
const String _sdkKey =
    "CE5VayNtNTzT5E0pIf7gKp4u_2SsU2zWdm0UiV4AWtOZBvKDP7ah3QHmxrJAciDHl0bugG2Q8P6lIPUwXpQWqM";
const String _bannerAdUnitId = "79cada275f161ce2";

// Create states
var _isInitialized = false;
var _isProgrammaticBannerCreated = false;
var _isProgrammaticBannerShowing = false;
var _isWidgetBannerShowing = false;

var _statusText = "";

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    initializePlugin();
  }

  // NOTE: Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initializePlugin() async {
    logStatus("Initializing SDK...");

    Map? configuration = await AppLovinMAX.initialize(_sdkKey);

    if (configuration != null) {
      _isInitialized = true;

      logStatus("SDK Initialized: $configuration");

      attachAdListeners();
    }
  }

  void attachAdListeners() {
    /// Banner Ad Listeners
    AppLovinMAX.setBannerListener(AdViewAdListener(onAdLoadedCallback: (ad) {
      logStatus('Banner ad loaded from ${ad.networkName}');
    }, onAdLoadFailedCallback: (adUnitId, error) {
      logStatus(
          'Banner ad failed to load with error code ${error.code} and message: ${error.message}');
    }, onAdClickedCallback: (ad) {
      logStatus('Banner ad clicked');
    }, onAdExpandedCallback: (ad) {
      logStatus('Banner ad expanded');
    }, onAdCollapsedCallback: (ad) {
      logStatus('Banner ad collapsed');
    }, onAdRevenuePaidCallback: (ad) {
      logStatus('Banner ad revenue paid: ${ad.revenue}');
    }));
  }

  String getProgrammaticBannerButtonTitle() {
    return _isProgrammaticBannerShowing
        ? 'Hide Programmatic Banner'
        : 'Show Programmatic Banner';
  }

  void logStatus(String status) {
    /// ignore: avoid_print
    print(status);

    setState(() {
      _statusText = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Demo Banner Ad"),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                '$_statusText\n',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: _isInitialized
                    ? () {
                        AppLovinMAX.showMediationDebugger();
                      }
                    : null,
                child: const Text("Mediation Debugger"),
              ),
              ElevatedButton(
                onPressed: (_isInitialized && !_isWidgetBannerShowing)
                    ? () async {
                        if (_isProgrammaticBannerShowing) {
                          AppLovinMAX.hideBanner(_bannerAdUnitId);
                        } else {
                          if (!_isProgrammaticBannerCreated) {
                            //
                            // Programmatic banner creation - banners are automatically sized to 320x50 on phones and 728x90 on tablets
                            //
                            AppLovinMAX.createBanner(
                                _bannerAdUnitId, AdViewPosition.bottomCenter);

                            // Set banner background color to black - PLEASE USE HEX STRINGS ONLY
                            AppLovinMAX.setBannerBackgroundColor(_bannerAdUnitId, '#000000');

                            _isProgrammaticBannerCreated = true;
                          }

                          AppLovinMAX.showBanner(_bannerAdUnitId);
                        }

                        setState(() {
                          _isProgrammaticBannerShowing = !_isProgrammaticBannerShowing;
                        });
                      }
                    : null,
                child: Text(getProgrammaticBannerButtonTitle()),
              ),
              if (_isWidgetBannerShowing)
                MaxAdView(
                    adUnitId: _bannerAdUnitId,
                    adFormat: AdFormat.banner,
                    listener: AdViewAdListener(onAdLoadedCallback: (ad) {
                      logStatus(
                          'Banner widget ad loaded from ${ad.networkName}');
                    }, onAdLoadFailedCallback: (adUnitId, error) {
                      logStatus(
                          'Banner widget ad failed to load with error code ${error.code} and message: ${error.message}');
                    }, onAdClickedCallback: (ad) {
                      logStatus('Banner widget ad clicked');
                    }, onAdExpandedCallback: (ad) {
                      logStatus('Banner widget ad expanded');
                    }, onAdCollapsedCallback: (ad) {
                      logStatus('Banner widget ad collapsed');
                    }, onAdRevenuePaidCallback: (ad) {
                      logStatus('Banner widget ad revenue paid: ${ad.revenue}');
                    })),
            ],
          )),
    );
  }
}
