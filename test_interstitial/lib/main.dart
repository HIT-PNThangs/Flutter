import 'dart:async';
import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';

enum AdLoadState { notLoaded, loading, loaded }

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

// Create constants
const String _sdkKey =
    "CE5VayNtNTzT5E0pIf7gKp4u_2SsU2zWdm0UiV4AWtOZBvKDP7ah3QHmxrJAciDHl0bugG2Q8P6lIPUwXpQWqM";
const String _interstitialAdUnitId = "2d3a3c7432a4bc68";

// Create states
var _isInitialized = false;
var _interstitialLoadState = AdLoadState.notLoaded;
var _interstitialRetryAttempt = 0;

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

    AppLovinMAX.loadInterstitial(_interstitialAdUnitId);
  }

  void attachAdListeners() {
    /// Interstitial Ad Listeners
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        _interstitialLoadState = AdLoadState.loaded;
        AppLovinMAX.loadInterstitial(_interstitialAdUnitId);

        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialAdReady(_interstitial_ad_unit_id) will now return 'true'
        logStatus('Interstitial ad loaded from ${ad.networkName}');

        // Reset retry attempt
        _interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        _interstitialLoadState = AdLoadState.notLoaded;

        // Interstitial ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        _interstitialRetryAttempt = _interstitialRetryAttempt + 1;

        int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();
        logStatus(
            'Interstitial ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadInterstitial(_interstitialAdUnitId);
        });
      },
      onAdDisplayedCallback: (ad) {
        logStatus('Interstitial ad displayed');
      },
      onAdDisplayFailedCallback: (ad, error) {
        _interstitialLoadState = AdLoadState.notLoaded;
        logStatus(
            'Interstitial ad failed to display with code ${error.code} and message ${error.message}');
      },
      onAdClickedCallback: (ad) {
        logStatus('Interstitial ad clicked');
      },
      onAdHiddenCallback: (ad) {
        _interstitialLoadState = AdLoadState.notLoaded;
        logStatus('Interstitial ad hidden');
      },
      onAdRevenuePaidCallback: (ad) {
        logStatus('Interstitial ad revenue paid: ${ad.revenue}');
      },
    ));
  }

  String getInterstitialButtonTitle() {
    if (_interstitialLoadState == AdLoadState.notLoaded) {
      return "Load Interstitial";
    } else if (_interstitialLoadState == AdLoadState.loading) {
      return "Loading...";
    } else {
      return "Show Interstitial";
    }
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
            title: const Text("Interstitial Demo"),
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
              // ElevatedButton(
              //   onPressed: _isInitialized
              //       ? () {
              //           AppLovinMAX.showMediationDebugger();
              //         }
              //       : null,
              //   child: const Text("Mediation Debugger"),
              // ),
              // ElevatedButton(
              //   onPressed: (_isInitialized && _interstitialLoadState != AdLoadState.loading)
              //       ? () async {
              //           bool isReady = (await AppLovinMAX.isInterstitialReady(_interstitialAdUnitId))!;
              //
              //           if (isReady) {
              //             AppLovinMAX.showInterstitial(_interstitialAdUnitId);
              //           } else {
              //             logStatus('Loading interstitial ad...');
              //             _interstitialLoadState = AdLoadState.loading;
              //             AppLovinMAX.loadInterstitial(_interstitialAdUnitId);
              //           }
              //         }
              //       : null,
              //   child: Text(getInterstitialButtonTitle()),
              // ),
              ElevatedButton(
                onPressed: (_isInitialized && _interstitialLoadState != AdLoadState.loading)
                    ? () async {
                        AppLovinMAX.showInterstitial(_interstitialAdUnitId);

                        // bool isReady = (await AppLovinMAX.isInterstitialReady(_interstitialAdUnitId))!;
                        //
                        // if (isReady) {
                        //   AppLovinMAX.showInterstitial(_interstitialAdUnitId);
                        // } else {
                        //   logStatus('Loading interstitial ad...');
                        //   _interstitialLoadState = AdLoadState.loading;
                        //   AppLovinMAX.loadInterstitial(_interstitialAdUnitId);
                        // }
                      }
                    : null,
                child: Text(getInterstitialButtonTitle()),
              ),
            ],
          )),
    );
  }
}
