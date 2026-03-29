import 'package:flutter_getx_boilerplate/utils/localization/en.dart';
import 'package:flutter_getx_boilerplate/utils/localization/vi.dart';
import 'package:get/get.dart';

class MyLocalization extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'en' : enLocalizedMap,
    'vi' : viLocalizedMap,
  };

  static String defaultLanguageCode = 'en';
  static List<String> supportedLanguageCodes = ['en', 'vi'];
  static Map<String, String> supportedLanguages = {
    'en' : 'English'.tr,
    'vi' : 'Vietnamese'.tr,
  };

  static String get currentLanguageCode {
    var code = Get.deviceLocale?.languageCode;
    if (code != null) {
      if (supportedLanguageCodes.contains(code)) {
        return code;
      }
    }
    return defaultLanguageCode;
  }

  static String get currentLanguage {
    var code = MyLocalization.currentLanguageCode;
    return supportedLanguages[code] ?? supportedLanguages[defaultLanguageCode]!;
  }
}
