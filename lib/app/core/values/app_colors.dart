import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppColors {
  AppColors._();
  static const Color primaryColor = Color(0xFF38305F);
  static const Color secondaryColor = Color(0xFF827717);

  static Color get backgroundColor => (Get.isDarkMode) ? darkBackgroundColor : lightBackgroundColor;

  static Color get textColor => (Get.isDarkMode) ? darkTextColor : lightTextColor;

  static Color get disabledTextColor => (Get.isDarkMode) ? darkTextColor.withOpacity(disabledTextOpacity) : lightTextColor.withOpacity(disabledTextOpacity);

  static Color get disabledIconColor => (Get.isDarkMode) ? darkTextColor.withOpacity(disabledIconOpacity) : lightTextColor.withOpacity(disabledIconOpacity);

  static Color get indicatorCircularColour => (Get.isDarkMode) ? indicatorCircularDarkModeColour : indicatorCircularLightModeColour;

  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color lightDeepBackgroundColor = Color(0xFFF0F2F5);
  static const Color lightTextColor = Color(0xFF000000);

  static const Color darkBackgroundColor = Color(0xFF242526);
  static const Color darkDeepBackgroundColor = Color(0xFF18191A);
  static const Color darkTextColor = Color(0xFFFFFFFF);

  static const Color inflowTextColor = Color(0x1E88E5FF);
  static const Color outflowTextColor = Color(0xE53935FF);

  static const double disabledTextOpacity = 0.35;
  static const double disabledIconOpacity = 0.25;

  static const Color secondaryButtonBGColor = Color(0x0B0A13FF);

  static const Color appbarColouredBorder = Color(0xFFBDBDBD);

  static const Color indicatorCircularLightModeColour = Color(0xFFF57C00);
  static const Color indicatorCircularDarkModeColour = Color(0xFFFAFAFA);
}
