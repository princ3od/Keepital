import 'dart:io';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/services/localization_service.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class SettingController extends GetxController {
  late final AppSettingStorage storage;
  final RxString defaultLanguage = "".obs;
  final RxString defaultCurrency = "".obs;
  static final RxString defaultThemeMode = "".obs;

  final showNotifications = true.obs;
  final allowSound = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await userAppSetting();
  }

  Future<void> userAppSetting() async {
    storage = AppSettingStorage();
    String value = await storage.readAppConfig();
    if (value != "") {
      var json = jsonDecode(value);
      defaultLanguage.value = json['default_language'];
      defaultCurrency.value = json['default_currency'];
      defaultThemeMode.value = json['default_them'];
      showNotifications.value = json['show_notifications'];
      allowSound.value = json['allow_sound'];
      LocalizationService.changeLocale(defaultLanguage.value);
      changedThemeMode();
    } else {
      String jsonAppSetting = jsonEncode(defaultSetting);
      await storage.writeUserAppSetting(jsonAppSetting);
    }
  }

  static void changedThemeMode() {
    Get.changeThemeMode(getThemeMode);
  }

  static ThemeMode get getThemeMode {
    if (defaultThemeMode.value == "Dark") {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  Map<String, dynamic> toJsonSetting() => {
        'default_language': defaultLanguage.value,
        'default_currency': defaultCurrency.value,
        'default_them': defaultThemeMode.value,
        'show_notifications': showNotifications.value,
        'allow_sound': allowSound.value,
      };

  Future<void> saveSetting() async {
    String jsonAppSetting = jsonEncode(toJsonSetting());
    await storage.writeUserAppSetting(jsonAppSetting);
  }

  void showWalletCurrencyPicker(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    return showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) async {
        defaultCurrency.value = currency.code;
        await saveSetting();
      },
      favorite: AppValue.favoritedCurrencies,
    );
  }
}

Map<String, dynamic> get defaultSetting => {
      'default_language': 'en',
      'default_currency': 'VND',
      'default_them': 'Light',
      'show_notifications': true,
      'allow_sound': false,
    };

class AppSettingStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/appConfig.in');
  }

  Future<File> writeUserAppSetting(String appConfig) async {
    final file = await _localFile;
    return file.writeAsString(appConfig);
  }

  Future<String> readAppConfig() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      return "";
    }
  }
}
