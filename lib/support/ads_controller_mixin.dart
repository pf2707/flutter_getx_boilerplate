
import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/manager/ads_manager.dart';
import 'package:flutter_getx_boilerplate/utils/helper.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const bool _preventAds = false;
mixin AdsControllerMixin {

  // Banner
  final Rx<BannerAd?> bannerAds = Rx<BannerAd?>(null);
  var isLoadingBannerAds = false;

  // Interstitial
  InterstitialAd? interstitialAds;
  var isLoadingInterstitialAds = false;

  // Rewarded Interstitial
  final Rx<RewardedInterstitialAd?> rewardedInterstitialAds = Rx<RewardedInterstitialAd?>(null);
  var isLoadingRewardedInterstitialAds = false;

  // Rewarded Live
  RewardedAd? liveRewardedAds;
  var isLoadingLiveRewardedAds = false;

  late final bool enableBanner;
  late final bool enableInterstitial;
  late final bool enableRewardedInterstitial;
  late final bool enableLiveRewarded;

  configureAds({
    bool enableBanner = false,
    bool enableInterstitial = false,
    bool enableRewardedInterstitial = false,
    bool enableLiveRewarded = false,
  }) {
    this.enableBanner = enableBanner;
    this.enableInterstitial = enableInterstitial;
    this.enableRewardedInterstitial = enableRewardedInterstitial;
    this.enableLiveRewarded = enableLiveRewarded;

    bannerAds.value = null;
    isLoadingBannerAds = false;

    interstitialAds = null;
    isLoadingInterstitialAds = false;

    rewardedInterstitialAds.value = null;
    isLoadingRewardedInterstitialAds = false;

    liveRewardedAds = null;
    isLoadingLiveRewardedAds = false;
  }

  resetAds() {
    isLoadingBannerAds = false;
    isLoadingInterstitialAds = false;
    isLoadingLiveRewardedAds = false;
    isLoadingRewardedInterstitialAds = false;
  }

  loadAds(BuildContext context) {
    if (_preventAds) { return; }

    if (enableBanner) {
      if (isLoadingBannerAds) { return; }

      debugLog("Load Banner Now");
      if (bannerAds.value == null && !isLoadingBannerAds) {
        isLoadingBannerAds = true;
        AdsManager.shared.loadBannerAds(context, (ads) {
          isLoadingBannerAds = false;
          bannerAds..value = ads..refresh();
        });
      }
    }
    if (enableInterstitial) {
      _loadInterstitialAds(context);
    }
    if (enableLiveRewarded) {
      _loadLiveRewardedAds(context);
    }
  }

  void _loadInterstitialAds(BuildContext context) {
    if (isLoadingInterstitialAds) { return; }

    debugLog("Load Interstitial Ads Now");
    if (interstitialAds == null && !isLoadingInterstitialAds) {
      isLoadingInterstitialAds = true;
      AdsManager.shared.loadInterstitialAds(context, (ads) {
        isLoadingInterstitialAds = false;
        interstitialAds = ads;
      });
    }
  }

  void _loadLiveRewardedAds(BuildContext context) {
    if (isLoadingLiveRewardedAds) { return; }

    debugLog("Load Live Rewarded Ads Now");
    if (liveRewardedAds == null && !isLoadingLiveRewardedAds) {
      isLoadingLiveRewardedAds = true;
      AdsManager.shared.loadLiveRewardedAds(context, (ads) {
        isLoadingLiveRewardedAds = false;
        liveRewardedAds = ads;
      });
    }
  }

  Widget bottomBannerAdsWidget() {
    return Obx(() {
      if (bannerAds.value != null) {
        return Positioned(
          left: 0, right: 0, bottom: 0,
          height: bannerAds.value!.size.height.toDouble(),
          child: SizedBox(
            width: double.infinity, height: double.infinity,
            child: AdWidget(ad: bannerAds.value!),
          ),
        );
      }
      return const SizedBox();
    });
  }

  showInterstitialAds({bool loadNextAfterClose = true}) {
    interstitialAds?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        // Called when the ad showed the full screen content.
        debugPrint('Ad showed full screen content.');
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        // Called when the ad failed to show full screen content.
        debugPrint('Ad failed to show full screen content with error: $err');
        // Dispose the ad here to free resources.
        ad.dispose();
      },
      onAdDismissedFullScreenContent: (ad) {
        // Called when the ad dismissed full screen content.
        debugPrint('Ad was dismissed.');
        // Dispose the ad here to free resources.
        ad.dispose();
        interstitialAds = null;
        _loadInterstitialAds(Get.context!);
      },
      onAdImpression: (ad) {
        // Called when an impression occurs on the ad.
        debugPrint('Ad recorded an impression.');
      },
      onAdClicked: (ad) {
        // Called when a click is recorded for an ad.
        debugPrint('Ad was clicked.');
      },
    );
    interstitialAds?.show();
  }

  showLiveRewardedAds({required Function(num) fnRewarded, bool loadNextAfterClose = true}) {
    liveRewardedAds?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        // Called when the ad showed the full screen content.
        debugPrint('Ad showed full screen content.');
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        // Called when the ad failed to show full screen content.
        debugPrint('Ad failed to show full screen content with error: $err');
        // Dispose the ad here to free resources.
        ad.dispose();
      },
      onAdDismissedFullScreenContent: (ad) {
        // Called when the ad dismissed full screen content.
        debugPrint('Ad was dismissed.');
        // Dispose the ad here to free resources.
        ad.dispose();
        liveRewardedAds = null;
        _loadLiveRewardedAds(Get.context!);
      },
      onAdImpression: (ad) {
        // Called when an impression occurs on the ad.
        debugPrint('Ad recorded an impression.');
      },
      onAdClicked: (ad) {
        // Called when a click is recorded for an ad.
        debugPrint('Ad was clicked.');
      },
    );
    liveRewardedAds?.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
        debugLog('Reward amount: ${rewardItem.amount}',);
        fnRewarded(rewardItem.amount);
      },
    );
  }
}