import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class FlutterAdmobAppOpen {
  static final FlutterAdmobAppOpen _instance = FlutterAdmobAppOpen._();

  static FlutterAdmobAppOpen get instance => _instance;

  static const MethodChannel _channel = MethodChannel('flutter_admob_app_open');

  static final String testAppId =
      Platform.isAndroid ? 'ca-app-pub-3940256099942544~3347511713' : 'ca-app-pub-3940256099942544~1458002511';

  static final String testAppOpenAdId =
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/1033173712' : 'ca-app-pub-3940256099942544/5662855259';

  FlutterAdmobAppOpen._();

  Future<bool?> initialize({
    String? appAppOpenAdUnitId,
    AdRequestAppOpen? targetingInfo,
  }) {
    return _channel.invokeMethod<bool>(
      'initialize',
      <String, dynamic>{
        'appAppOpenAdUnitId': appAppOpenAdUnitId,
        'targetingInfo': targetingInfo?.toJson(),
      },
    );
  }

  Future<bool?> pause() {
    return _channel.invokeMethod<bool>('pause');
  }

  Future<bool?> resume() {
    return _channel.invokeMethod<bool>('resume');
  }
}

class AdRequestAppOpen {
  const AdRequestAppOpen({
    this.keywords,
    this.contentUrl,
    this.nonPersonalizedAds,
  });

  final List<String>? keywords;
  final String? contentUrl;
  final bool? nonPersonalizedAds;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{
      'requestAgent': 'flutter-alpha',
    };

    if (keywords != null && keywords!.isNotEmpty) {
      assert(keywords!.every((String s) => s.isNotEmpty));
      json['keywords'] = keywords;
    }
    if (nonPersonalizedAds != null) json['nonPersonalizedAds'] = nonPersonalizedAds;
    if (contentUrl != null && contentUrl!.isNotEmpty) json['contentUrl'] = contentUrl;

    return json;
  }

  factory AdRequestAppOpen.fromJson(Map<String, dynamic> json) {
    return AdRequestAppOpen(
      keywords: json['keywords'] ?? [],
      nonPersonalizedAds: json['nonPersonalizedAds'],
      contentUrl: json['contentUrl'],
    );
  }
}
