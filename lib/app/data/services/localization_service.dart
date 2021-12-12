import 'dart:collection';
import 'dart:convert';

import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/languages/en_US.dart';
import 'package:keepital/app/core/values/languages/vi_VN.dart';
import 'package:keepital/app/modules/app_setting/setting_controller.dart';

class LocalizationService extends Translations {
  static final locale = _getLocaleFromLanguage();

  static final fallbackLocale = Locale('en', 'US');

  static final languageCodes = [
    'en',
    'vi',
  ];

// các Locale được support
  static final locales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
  ];

  static final langs = LinkedHashMap.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
  });

  static void changeLocale(String _languageCode) {
    final locale = _getLocaleFromLanguage(languageCode: _languageCode);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enLanguagePackage,
        'vi_VN': viLanguagePackage,
      };

  static Locale _getLocaleFromLanguage({String? languageCode}) {
    var lang = languageCode ?? Get.deviceLocale!.languageCode;
    for (int i = 0; i < languageCodes.length; i++) {
      if (lang == languageCodes[i]) return locales[i];
    }
    return Get.locale!;
  }

  Future<String?> getLanguague() async {
    var storage = AppSettingStorage();
    String value = await storage.readAppConfig();
    if (value != "") {
      var json = jsonDecode(value);
      var defaultLanguage = json['default_language'];
      return defaultLanguage;
    }
  }
}
