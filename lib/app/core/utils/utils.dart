import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/global_widgets/default_loading.dart';

class Utils {
  static bool isLightMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }

  static Future<dynamic> showLoadingDialog() async {
    return await Get.dialog(Center(child: DefaultLoading()));
  }

  static void hideLoadingDialog() {
    Get.back();
  }
}

extension DateToString on DateTime {
  String get fullDate => DateFormat(FormatValue.fullDateFormat, Get.locale.toString()).format(this);
  String get monthReducedDate => DateFormat(FormatValue.monthReducedDateFormat, Get.locale.toString()).format(this);
  String get numbericDate => DateFormat(FormatValue.numbericDateFormat, Get.locale.toString()).format(this);
  String get dayInWeek => DateFormat(FormatValue.dayFormat, Get.locale.toString()).format(this);
  String get fullMonth => DateFormat(FormatValue.fullMonthFormat, Get.locale.toString()).format(this);
  String get onlyDate => DateFormat(FormatValue.onlyDateFormat, Get.locale.toString()).format(this);
  String get shortMonth => DateFormat(FormatValue.shortMonthFormat, Get.locale.toString()).format(this);
  String get dayInMonth => DateFormat(FormatValue.dayInMonthFormat, Get.locale.toString()).format(this);
  String get fullYear => DateFormat(FormatValue.yearFormat, Get.locale.toString()).format(this);
  String get monthNDay => DateFormat(FormatValue.monthNDayFormat, Get.locale.toString()).format(this);
}

extension DoubleToMoney on double {
  String money(String symbol) => NumberFormat.currency(locale: Get.locale.toString(), symbol: symbol).format(this);
  String get readable => NumberFormat.decimalPattern().format(this);
}

extension NumToMoney on num {
  String money(String symbol) => NumberFormat.currency(locale: Get.locale.toString(), symbol: symbol).format(this);
  String get readable => NumberFormat.decimalPattern().format(this);
}

extension StringToDateTime on String {
  DateTime date() {
    DateFormat format = DateFormat(FormatValue.fullDateFormat, Get.locale.toString());
    return format.parse(this);
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
