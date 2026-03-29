
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_getx_boilerplate/manager/ads_manager.dart';

class AdsConstant {
  // Private static instance variable
  static final AdsConstant _instance = AdsConstant._internal();

  // Private constructor to prevent direct instantiation
  AdsConstant._internal();

  // Factory constructor to provide the single instance
  factory AdsConstant() {
    return _instance;
  }

  /// Banner
  _AdsIdItem? _bannerAdsInternal;
  _AdsIdItem get _bannerAds {
    if (Platform.isIOS) {
      _bannerAdsInternal ??= _AdsIdItem(
        prodId: "ca-app-pub-1111111111111111/0101010101",
        testId: "ca-app-pub-2222222222222222/1010101010",
      );
    } else if (Platform.isAndroid) {
      _bannerAdsInternal ??= _AdsIdItem(
        prodId: "ca-app-pub-3333333333333333/0202020202",
        testId: "ca-app-pub-4444444444444444/2020202020",
      );
    } else {
      _bannerAdsInternal ??= _AdsIdItem.empty();
    }
    return _bannerAdsInternal!;
  }

  String get bannerAdsId {
    return _bannerAds.adsUnitId;
  }

  /// Interstitial
  _AdsIdItem? _interstitialAdsInternal;
  _AdsIdItem get _interstitialAds {
    if (Platform.isIOS) {
      _interstitialAdsInternal ??= _AdsIdItem(
        prodId: "ca-app-pub-5555555555555555/0303030303",
        testId: "ca-app-pub-6666666666666666/3030303030",
      );
    } else if (Platform.isAndroid) {
      _interstitialAdsInternal ??= _AdsIdItem(
        prodId: "ca-app-pub-7777777777777777/0404040404",
        testId: "ca-app-pub-8888888888888888/4040404040",
      );
    } else {
      _interstitialAdsInternal ??= _AdsIdItem.empty();
    }
    return _interstitialAdsInternal!;
  }

  String get interstitialAdsId {
    return _interstitialAds.adsUnitId;
  }

  /// Rewarded for Live
  _AdsIdItem? _rewardedAdsInternal;
  _AdsIdItem get _rewardedAds {
    if (Platform.isIOS) {
      _rewardedAdsInternal ??= _AdsIdItem(
        prodId: "ca-app-pub-9999999999999999/0505050505",
        testId: "ca-app-pub-1010101010101010/5050505050",
      );
    } else if (Platform.isAndroid) {
      _rewardedAdsInternal ??= _AdsIdItem(
        prodId: "ca-app-pub-100100100100100100/0606060606",
        testId: "ca-app-pub-101101101101101101/6060606060",
      );
    } else {
      _rewardedAdsInternal ??= _AdsIdItem.empty();
    }
    return _rewardedAdsInternal!;
  }

  String get liveRewardedAdsId {
    return _rewardedAds.adsUnitId;
  }

  /// Interstitial Rewarded
  _AdsIdItem? _interstitialRewardedAdsInternal;
  _AdsIdItem get _interstitialRewardedAds {
    if (Platform.isIOS) {
      _interstitialRewardedAdsInternal ??= _AdsIdItem(
        prodId: "ca-app-pub-106106106106106106/0909090909",
        testId: "ca-app-pub-107107107107107107/9090909090",
      );
    } else if (Platform.isAndroid) {
      _interstitialRewardedAdsInternal ??= _AdsIdItem(
        prodId: "ca-app-pub-108108108108108108/0010101010",
        testId: "ca-app-pub-109109109109109109/10101010111",
      );
    } else {
      _interstitialRewardedAdsInternal ??= _AdsIdItem.empty();
    }
    return _interstitialRewardedAdsInternal!;
  }

  String get interstitialRewardedAdsId {
    return _interstitialRewardedAds.adsUnitId;
  }
}

class _AdsIdItem {
  final String prodId;
  final String testId;

  _AdsIdItem({
    required this.prodId,
    required this.testId,
  });

  _AdsIdItem.empty()
    : prodId = "", testId = "";

  String get adsUnitId {
    return (kDebugMode || AdsManager.shared.forceShowTestAds) ? testId : prodId;
  }
}