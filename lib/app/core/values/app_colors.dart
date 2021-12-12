import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  AppColors._();
  static const Color primaryColor = Color(0xFF38305F);
  static const Color secondaryColor = Color(0xFF827717);
  static const whiteAccentColor = Color(0xffFAFAFA);

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

  static Color get calculatorForegroundColor => Get.isDarkMode ? _calculatorForegroundDarkColor : _calculatorForegroundLightColor;
  static Color _calculatorForegroundLightColor = Color(0xffdbdddd);
  static Color _calculatorForegroundDarkColor = Color(0xffdbdddd);

  static Color get calculatorNumberButtonBackgroundColor => Get.isDarkMode ? _calculatorNumberButtonBackgroundDarkColor : _calculatorNumberButtonBackgroundLightColor;
  static Color _calculatorNumberButtonBackgroundLightColor = Color(0xff282c35);
  static Color _calculatorNumberButtonBackgroundDarkColor = Color(0xff282c35);

  static Color _calculatorFunctionButtonLightColor = Color(0xff444b59);
  static Color _calculatorFunctionButtonDarkColor = Color(0xff444b59);
  static Color get calculatorFunctionButtonColor => Get.isDarkMode ? _calculatorFunctionButtonDarkColor : _calculatorFunctionButtonLightColor;

  static Color _calculatorCancelButtonLightColor = Color(0xffb34048);
  static Color _calculatorCancelButtonDarkColor = Color(0xffb34048);
  static Color get calculatorCancelButtonColor => Get.isDarkMode ? _calculatorCancelButtonDarkColor : _calculatorCancelButtonLightColor;

  static Color calculatorCompleteButtonLightColor = Color(0xFF4FCC5C);
  static Color calculatorCompleteButtonDarkColor = Color(0xFF4FCC5C);
  static Color get calculatorCompleteButtonColor => Get.isDarkMode ? calculatorCompleteButtonDarkColor : calculatorCompleteButtonLightColor;

  static Color _calculatorCalculateButtonLightColor = Color(0xff444b59);
  static Color _calculatorCalculateButtonDarkColor = Color(0xff444b59);
  static Color get calculatorCalculateButtonColor => Get.isDarkMode ? _calculatorCalculateButtonDarkColor : _calculatorCalculateButtonLightColor;

  static const Color _caculatorBackgroundDarkColor = Color(0xff797B7E);
  static const Color _caculatorBackgroundLightColor = Color(0x66BCBCBC);
  static Color get calculatorBackgroundColor => Get.isDarkMode ? _caculatorBackgroundDarkColor.withOpacity(0.2) : _caculatorBackgroundLightColor;

  static const Color textFieldBackgroundDarkColor = Color(0xFF242526);
  static const Color textFieldBackgroundLightColor = Color(0xFF38305F);

  static List<Color> pieChartCategoryColors = [
    Color(0xFF004766),
    Color(0xFF005F73),
    Color(0xFF0A9396),
    Color(0xFF94D2BD),
    Color(0xFFE9D8A6),
    Color(0xFFE9D8A6),
    Color(0xFFEE9B00),
    Color(0xFFCA6702),
    Color(0xFF9B2226),
  ];
  static Color pieChartExtendedCategoryColor = Colors.grey;
}
