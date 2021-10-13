import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppColors {
  AppColors._();
  static const Color primaryColor = Color(0xFF38305f);
  static const Color secondaryColor = Color(0xFF827717);

  static Color get backgroundColor =>
      (Get.isDarkMode) ? darkBgColor : lightBgColor;

  static Color get textColor =>
      (Get.isDarkMode) ? darkTextColor : lightTextColor;

  static Color get disabledTextColor => (Get.isDarkMode)
      ? darkTextColor.withOpacity(disabledTextOpacity)
      : lightTextColor.withOpacity(disabledTextOpacity);

  static Color get disabledIconColor => (Get.isDarkMode)
      ? darkTextColor.withOpacity(disabledIconOpacity)
      : lightTextColor.withOpacity(disabledIconOpacity);

  static const Color lightBgColor = Color(0xFFFFFFFF);
  static const Color lightDeepBgColor = Color(0xFFF0F2F5);
  static const Color lightTextColor = Color(0xFF000000);

  static const Color darkBgColor = Color(0xFF242526);
  static const Color darkDeepBgColor = Color(0xFF18191A);
  static const Color darkTextColor = Color(0xFFFFFFFF);

  static const Color inflowTextColor = Color(0xFFFFFFFF);
  static const Color outflowTextColor = Color(0xFFFFFFFF);

  static const double disabledTextOpacity = 0.38;
  static const double disabledIconOpacity = 0.28;
}
