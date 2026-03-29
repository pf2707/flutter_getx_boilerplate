import 'package:flutter_getx_boilerplate/support/ads_controller_mixin.dart';
import 'package:get/get.dart';

class AController extends GetxController with AdsControllerMixin {

  @override
  void onInit() {
    super.onInit();
    configureAds(enableBanner: true, enableInterstitial: true, enableLiveRewarded: false, enableRewardedInterstitial: false);
  }

  prepare() {
    resetAds();

    Future.delayed(const Duration(milliseconds: 3000), () {
      showInterstitialAds();
    });
  }
}