import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/providers/exchange_rate_provider.dart';
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
  String exchange(String origin, String target, String symbol) => ExchangeRate.exchange(origin, target, this).money(symbol);
  String get readable => NumberFormat.decimalPattern().format(this);
}

extension NumToMoney on num {
  String money(String symbol) => NumberFormat.currency(locale: Get.locale.toString(), symbol: symbol).format(this);
  String exchange(String origin, String target, String symbol) => ExchangeRate.exchange(origin, target, this.toDouble()).money(symbol);
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

  bool isStrictlyBeforeDate(DateTime other) {
    return year < other.year || year == other.year && month < other.month || year == other.year && month == other.month && day < other.day;
  }

  bool isBeforeDate(DateTime other) {
    return isSameDate(other) || isStrictlyBeforeDate(other);
  }

  bool isAfterDate(DateTime other) {
    return !isStrictlyBeforeDate(other);
  }

  bool isStrictlyAfterDate(DateTime other) {
    return !isBeforeDate(other);
  }

  bool isToday() {
    return isSameDate(DateTime.now());
  }
}

List<String> stringToList(String? str) {
  if (str == null) return [];
  var res = str.split(',');
  for (int i = 0; i < res.length; i++) {
    res[i] = res[i].trim();
  }
  if (res.last == ' ' || res.last == '') res.remove(res.last);
  return res;
}

String listToString(List<String>? l) {
  if (l == null) return '';
  String res = '';
  for (var str in l) {
    res += '$str, ';
  }
  return res;
}

const recurUnits = ['days', 'weeks', 'months', 'years'];
const recurOpts = ['Forever', 'Until', 'For'];
