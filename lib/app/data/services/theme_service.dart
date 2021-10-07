import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  static final _box = GetStorage();
  static final _key = 'isDarkMode';

  static ThemeMode get theme =>
      _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  static bool _loadThemeFromBox() => _box.read(_key) ?? false;

  static _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  static void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
