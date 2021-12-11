import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/providers/exchange_rate_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
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

  bool isBetweenDates(DateTime start, DateTime end) {
    return this.isAfterDate(start) && this.isBeforeDate(end);
  }
}

extension SpecialDay on DateTime {
  DateTime firstDateOfWeek() => this.subtract(Duration(days: this.weekday - 1));
  DateTime lastDateOfWeek() => this.add(Duration(days: DateTime.daysPerWeek - this.weekday));
  DateTime firstDateOfNextWeek() {
    DateTime sameWeekDayOfNextWeek = this.add(const Duration(days: 7));
    return sameWeekDayOfNextWeek.firstDateOfWeek();
  }

  DateTime lastDateOfNextWeek() {
    DateTime sameWeekDayOfNextWeek = this.add(const Duration(days: 7));
    return sameWeekDayOfNextWeek.lastDateOfWeek();
  }

  DateTime firstDateOfMonth() {
    return DateTime(this.year, this.month, 1);
  }

  DateTime lastDateOfMonth() {
    return DateTime(this.year, this.month + 1, 0);
  }

  DateTime firstDateOfNextMonth() {
    return DateTime(this.year, this.month + 1, 1);
  }

  DateTime lastDateOfNextMonth() {
    var date = this.firstDateOfNextMonth();
    return date.lastDateOfMonth();
  }

  DateTime firstDateOfQuarter() {
    int quarterNumber = ((this.month - 1) / 3 + 1).toInt();
    return DateTime(this.year, (quarterNumber - 1) * 3 + 1, 1);
  }

  DateTime lastDateOfQuarter() {
    var first = this.firstDateOfQuarter();
    return DateTime(first.year, first.month + 3, 0);
  }

  DateTime firstDateOfNextQuarter() {
    int quarterNumber = ((this.month - 1) / 3 + 1).toInt();
    quarterNumber = quarterNumber % 4 + 1;
    return DateTime(this.year, (quarterNumber - 1) * 3 + 1, 1);
  }

  DateTime lastDateOfNextQuarter() {
    var first = this.firstDateOfNextQuarter();
    return DateTime(first.year, first.month + 3, 0);
  }

  DateTime firstDateOfYear() {
    return DateTime(this.year, 1, 1);
  }

  DateTime lastDateOfYear() {
    return DateTime(this.year, 12, 31);
  }

  DateTime firstDateOfNextYear() {
    return DateTime(this.year + 1, 1, 1);
  }

  DateTime lastDateOfNextYear() {
    return DateTime(this.year + 1, 12, 31);
  }
}

String getStringRange(DateTime start, DateTime end) {
  var now = DateTime.now();
  if (start.isSameDate(now.firstDateOfWeek()) && end.isSameDate(now.lastDateOfWeek())) {
    return 'This week'.tr;
  } else if (start.isSameDate(now.firstDateOfNextWeek()) && end.isSameDate(now.lastDateOfNextWeek())) {
    return 'Next week'.tr;
  } else if (start == now.firstDateOfMonth() && end == now.lastDateOfMonth()) {
    return 'This month'.tr;
  } else if (start == now.firstDateOfNextMonth() && end == now.lastDateOfNextMonth()) {
    return 'Next month'.tr;
  } else if (start == now.firstDateOfQuarter() && end == now.lastDateOfQuarter()) {
    return 'This quarter'.tr;
  } else if (start == now.firstDateOfNextQuarter() && end == now.lastDateOfNextQuarter()) {
    return 'Next quarter'.tr;
  } else if (start == now.firstDateOfYear() && end == now.lastDateOfYear()) {
    return 'This year'.tr;
  } else if (start == now.firstDateOfNextYear() && end == now.lastDateOfNextYear()) {
    return 'Next year'.tr;
  }
  return '${start.numbericDate} - ${end.numbericDate}';
}

String currencySymbol(String walletId) => DataService.currentUser!.wallets[walletId]?.currencySymbol ?? 'None';

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
