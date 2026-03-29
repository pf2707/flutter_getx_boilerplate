
import 'dart:io';

import 'package:flutter_getx_boilerplate/constant/constant.dart';
import 'package:flutter_getx_boilerplate/manager/ads_manager.dart';
import 'package:flutter_getx_boilerplate/manager/data_manager.dart';
import 'package:flutter_getx_boilerplate/utils/helper.dart';
import 'package:flutter_getx_boilerplate/utils/my_localization.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class SettingManager {
  static var shared = SettingManager();

  String? uniqueDeviceId;

  var appLanguageCode = MyLocalization.currentLanguageCode.obs;
  late Directory applicationDocumentPath;

  bool get isSignedIn {
    return DataManager.shared.isLogin;
  }

  prepare() async {
    uniqueDeviceId = await Helper.getUniqueDeviceId();
    applicationDocumentPath = await getApplicationDocumentsDirectory();
    appLanguageCode.value = MyLocalization.currentLanguageCode;
  }

  bool get isVietnamese => appLanguageCode.value == "vi";

  enableSecretFunction() {
    AdsManager.shared.forceShowTestAds = true;
  }
}