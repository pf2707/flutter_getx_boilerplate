
import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/constant/app_colors.dart';
import 'package:flutter_getx_boilerplate/screen/a/a_controller.dart';
import 'package:get/get.dart';

class AScreen extends GetView<AController> {
  final String? code;
  AScreen({super.key, this.code}) {
    controller.prepare();
  }

  @override
  Widget build(BuildContext context) {
    controller.loadAds(context);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        child: Stack(
          children: [

            /// Bottom Ads Banner
            controller.bottomBannerAdsWidget(),
          ],
        ),
      ),
    );
  }
}