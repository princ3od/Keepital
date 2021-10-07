import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppColors {
  AppColors._();
  static const Color primaryColor = Color(0xFF38305f);
  static const Color secondaryColor = Color(0xFF827717);
  static Color get backgroundColor =>
      (Get.isDarkMode) ? darkBgColor : lightBgColor;

  static const Color lightBgColor = Color(0xFFFFFFFF);
  static const Color lightTextColor = Color(0xFF000000);

  static const Color darkBgColor = Color(0xFF121212);
  static const Color darkTextColor = Color(0xFFFFFFFF);
}
