import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keepital/app/core/values/app_value.dart';

class Utils {
  static bool isLightMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }
}

extension DateToString on DateTime {
  String get fullDate => DateFormat(FormatValue.fullDateFormat, Get.locale.toString()).format(this);
  String get monthReducedDate => DateFormat(FormatValue.monthReducedDateFormat, Get.locale.toString()).format(this);
  String get numbericDate => DateFormat(FormatValue.numbericDateFormat, Get.locale.toString()).format(this);
  String get dayInWeek => DateFormat(FormatValue.dayFormat, Get.locale.toString()).format(this);
}

extension DoubleToMoney on double {
  String money(String symbol) => NumberFormat.currency(locale: Get.locale.toString(), symbol: symbol).format(this);
  String get readable => NumberFormat.decimalPattern().format(this);
}

extension NumToMoney on num {
  String money(String symbol) => NumberFormat.currency(locale: Get.locale.toString(), symbol: symbol).format(this);
  String get readable => NumberFormat.decimalPattern().format(this);
}
