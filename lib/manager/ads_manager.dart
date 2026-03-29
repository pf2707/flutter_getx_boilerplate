

import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/constant/ads_constant.dart';
import 'package:flutter_getx_boilerplate/utils/helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsManager {
  static final shared = AdsManager();
  var forceShowTestAds = false;

  prepare() async {
    await MobileAds.instance.initialize();

    final config = RequestConfiguration(testDeviceIds: ["0FC2CCC10B61214103FE2A6968C85DE1"]);
    MobileAds.instance.updateRequestConfiguration(config);
  }

  void loadBannerAds(BuildContext context, Function(BannerAd?) fnLoadedAds) async {
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      MediaQuery.sizeOf(context).width.truncate(),
    );

    if (size == null) {
      // Unable to get width of anchored banner.
      return;
    }

    final adsId = AdsConstant().bannerAdsId;

    if (adsId.isNotEmpty) {
      BannerAd(
        adUnitId: adsId,
        request: const AdRequest(),
        size: size,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            // Called when an ad is successfully received.
            debugLog("Banner Ad was loaded.");
            fnLoadedAds(ad as BannerAd);
          },
          onAdFailedToLoad: (ad, err) {
            // Called when an ad request failed.
            debugLog("Ad failed to load with error: $err");
            ad.dispose();
            fnLoadedAds(null);
          },
        ),
      ).load();
    }
  }

  void loadInterstitialAds(BuildContext context, Function(InterstitialAd?) fnLoadedAds) async {
    final adsId = AdsConstant().interstitialAdsId;

    if (adsId.isNotEmpty) {
      InterstitialAd.load(
        adUnitId: adsId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Called when an ad is successfully received.
            debugLog('Interstitial Ad was loaded.');
            // Keep a reference to the ad so you can show it later.
            fnLoadedAds(ad);
          },
          onAdFailedToLoad: (LoadAdError error) {
            // Called when an ad request failed.
            debugLog('Ad failed to load with error: $error');
            fnLoadedAds(null);
          },
        ),
      );
    }
  }

  void loadLiveRewardedAds(BuildContext context, Function(RewardedAd?) fnLoadedAds) async {
    final adsId = AdsConstant().liveRewardedAdsId;

    if (adsId.isNotEmpty) {
      RewardedAd.load(
        adUnitId: adsId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            // Called when an ad is successfully received.
            debugPrint('Ad was loaded.');
            // Keep a reference to the ad so you can show it later.
            fnLoadedAds(ad);
          },
          onAdFailedToLoad: (LoadAdError error) {
            // Called when an ad request failed.
            debugPrint('Ad failed to load with error: $error');
            fnLoadedAds(null);
          },
        ),
      );
    }
  }
}