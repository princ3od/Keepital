import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/home/home_controller.dart';

class ReportController {
  static double openingBalance(List<TransactionModel> transactions, DateTime startDate) {
    double openingBalance = DataService.currentWallet.value.amount.toDouble();

    for (var transaction in transactions) {
      if (transaction.date.isAfter(startDate) || transaction.date.isSameDate(startDate)) {
        openingBalance += (transaction.category.type == CategoryType.expense) ? transaction.amount : -transaction.amount;
      }
    }
    return openingBalance;
  }

  static double closingBalance(List<TransactionModel> transactions, DateTime endDate) {
    double closingBalance = DataService.currentWallet.value.amount.toDouble();
    for (var transaction in transactions) {
      if (transaction.date.isAfter(endDate)) {
        closingBalance += (transaction.category.type == CategoryType.expense) ? transaction.amount : -transaction.amount;
      }
    }
    return closingBalance;
  }

  static List<TransactionModel> transactionsInRange(List<TransactionModel> transactions, DateTimeRange range) {
    List<TransactionModel> transactionsInRange = [];
    for (var transaction in transactions) {
      if (transaction.date.isBetweenDates(range.start, range.end)) {
        transactionsInRange.add(transaction);
      }
    }
    return transactionsInRange;
  }

  static double income(List<TransactionModel> transactions) {
    double _income = 0;
    for (var transaction in transactions) {
      if (transaction.category.type == CategoryType.income) {
        _income += transaction.amount;
      }
    }
    return _income;
  }

  static double expense(List<TransactionModel> transactions) {
    double _expense = 0;
    for (var transaction in transactions) {
      if (transaction.category.type == CategoryType.expense) {
        _expense += transaction.amount;
      }
    }
    return _expense;
  }

  static List<double> getExpenseAndIncome(List<TransactionModel> transactions, DateTimeRange range) {
    List<double> _expenseAndIncome = [0, 0];
    for (var transaction in transactions) {
      if (transaction.date.isBetweenDates(range.start, range.end)) {
        var isExpense = transaction.category.type == CategoryType.expense;
        _expenseAndIncome[isExpense ? 0 : 1] += transaction.category.type == CategoryType.expense ? -transaction.amount : transaction.amount;
      }
    }
    return _expenseAndIncome;
  }

  static List<double> getMinAndMax(List<List<double>> data) {
    List<double> _minAndMax = [0, 0];
    for (var item in data) {
      if (item[0] < _minAndMax[0]) {
        _minAndMax[0] = item[0];
      }
      if (item[1] > _minAndMax[1]) {
        _minAndMax[1] = item[1];
      }
    }
    return _minAndMax;
  }

  static Map<String, List<double>> chartTimeData(List<TransactionModel> transactions, DateTimeRange range, TimeRange timeRangeType) {
    Map<String, List<double>> _timeRanges = {};
    switch (timeRangeType) {
      case TimeRange.day:
        _timeRanges[range.end.numbericDate] = getExpenseAndIncome(transactions, range);
        break;
      case TimeRange.week:
        DateTime _startDate = range.start;
        while (!_startDate.isAfter(range.end)) {
          _timeRanges[_startDate.numbericDate] = getExpenseAndIncome(transactions, DateTimeRange(start: _startDate, end: _startDate));
          _startDate = _startDate.add(Duration(days: 1));
        }
        break;
      case TimeRange.month:
        DateTime _startDate = range.start;
        int dayRange = range.duration.inDays ~/ 5;
        while (_startDate.isBefore(range.end)) {
          var _endDate = _startDate.add(Duration(days: dayRange));
          if (_endDate.isAfter(range.end)) {
            _endDate = range.end;
          }
          _timeRanges[_startDate.dayInMonth + ' - ' + _endDate.dayInMonth] = getExpenseAndIncome(transactions, DateTimeRange(start: _startDate, end: _endDate));
          _startDate = _endDate;
        }
        break;
      case TimeRange.quarter:
        for (var i = range.start.month; i <= range.end.month; i++) {
          var _startDate = DateTime(range.start.year, i, 1);
          var _endDate = DateTime(range.start.year, i + 1, 0);
          _timeRanges[_startDate.shortMonth] = getExpenseAndIncome(transactions, DateTimeRange(start: _startDate, end: _endDate));
        }
        break;
      case TimeRange.year:
        for (var i = 1; i <= 12; i++) {
          var _startDate = DateTime(range.start.year, i, 1);
          var _endDate = DateTime(range.start.year, i + 1, 0);
          _timeRanges[_startDate.shortMonth] = getExpenseAndIncome(transactions, DateTimeRange(start: _startDate, end: _endDate));
        }
        break;
      case TimeRange.all:
        break;
      default:
        break;
    }
    return _timeRanges;
  }

  static DateTimeRange getTimeRangeBaseOnTime(TimeRange timeRange, String chooseTab) {
    switch (timeRange) {
      case TimeRange.month:
        return _getTimeRangeBaseOnMonth(chooseTab);
      case TimeRange.day:
        return _getTimeRangeBaseOnDay(chooseTab);
      case TimeRange.week:
        return _getTimeBaseOnWeek(chooseTab);
      case TimeRange.quarter:
        return _getTimeBaseOnQuater(chooseTab);
      case TimeRange.year:
        return _getTimeRangeBaseOnYear(chooseTab);
      case TimeRange.all:
        return DateTimeRange(start: AppValue.minDateTime, end: AppValue.maxDateTime);
      default:
        return DateTimeRange(start: AppValue.minDateTime, end: AppValue.maxDateTime);
    }
  }

  static DateTimeRange _getTimeRangeBaseOnMonth(String chooseTab) {
    var chooseTime = chooseTab.split('/');

    if (chooseTime.length == 1) {
      chooseTime.clear();
      int nowMonth = DateTime.now().month;
      int nowYear = DateTime.now().year;

      if (chooseTab == 'LAST MONTH'.tr) {
        chooseTime.add((nowMonth - 1).toString());
        chooseTime.add(nowYear.toString());
      } else if (chooseTab == 'THIS MONTH'.tr) {
        chooseTime.add((nowMonth).toString());
        chooseTime.add(nowYear.toString());
      } else {
        chooseTime.add((nowMonth + 1).toString());
        chooseTime.add(nowYear.toString());
      }
    }
    DateTime startDate = DateTime(int.parse(chooseTime[1]), int.parse(chooseTime[0]), 1);
    DateTime endDate = DateTime(startDate.year, startDate.month + 1, 0);
    return DateTimeRange(start: startDate, end: endDate);
  }

  static DateTimeRange _getTimeRangeBaseOnDay(String chooseTab) {
    DateTime choseDate = DateTime.now();
    try {
      choseDate = chooseTab.date();
    } catch (identifier) {
      if (chooseTab == 'YESTERDAY'.tr) {
        choseDate = choseDate.subtract(Duration(days: 1));
      } else if (chooseTab == 'FUTURE'.tr) {
        return DateTimeRange(start: choseDate.add(Duration(days: 1)), end: AppValue.maxDateTime);
      } else {
        choseDate = choseDate;
      }
    }

    DateTime startDate = choseDate;
    DateTime endDate = choseDate;
    return DateTimeRange(start: startDate, end: endDate);
  }

  static DateTimeRange _getTimeBaseOnWeek(String chooseTab) {
    List<String> chooseTime = [];
    chooseTime = chooseTab.split(' - ');

    var headDateList;
    DateTime headTime = DateTime.now();
    DateTime tailTime = DateTime.now();

    if (chooseTime.length == 1) {
      chooseTime.clear();

      var firstDatePresent = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).subtract(Duration(days: DateTime.now().weekday - 1));
      var lastDatePresent = firstDatePresent.add(Duration(days: 7));

      var firstDateInPast = firstDatePresent.subtract(Duration(days: 7));
      var lastDateInPast = firstDateInPast.add(Duration(days: 6));

      var firstDateInFutre = firstDatePresent.add(Duration(days: 7));

      if (chooseTab == 'LAST WEEK'.tr) {
        headTime = firstDateInPast;
        tailTime = lastDateInPast;
      } else if (chooseTab == 'THIS WEEK'.tr) {
        headTime = firstDatePresent;
        tailTime = lastDatePresent;
      } else {
        headTime = firstDateInFutre;
      }
    } else {
      headDateList = chooseTime[0].split('/');
      headTime = DateTime(DateTime.now().year, int.parse(headDateList[1]), int.parse(headDateList[0]));
      tailTime = headTime.add(Duration(days: 6));
    }
    if (tailTime.isBefore(headTime)) {
      tailTime = headTime.add(Duration(days: 6));
    }
    return DateTimeRange(start: headTime, end: tailTime);
  }

  static DateTimeRange _getTimeBaseOnQuater(String chooseTab) {
    List<String> chooseTime = [];
    chooseTime = chooseTab.split(' ');

    DateTime headTime = DateTime.now();
    DateTime tailTime = DateTime.now();
    DateTime now = DateTime.now();
    var x = Get.find<HomeController>().tabs[18].data!.split(' ');

    if (chooseTab == 'FUTURE'.tr) {
      tailTime = AppValue.maxDateTime;
      switch (x[0]) {
        case 'Q1':
          headTime = DateTime(now.year, DateTime.april, 1);
          break;
        case 'Q2':
          headTime = DateTime(now.year, DateTime.july, 1);
          break;
        case 'Q3':
          headTime = DateTime(now.year, DateTime.october, 1);
          break;
        case 'Q4':
          headTime = DateTime(now.year + 1, DateTime.april, 1);
          break;
        default:
      }
    } else {
      now = DateTime(int.parse(chooseTime[1]));
      switch (chooseTime[0]) {
        case 'Q1':
          headTime = DateTime(now.year, DateTime.january, 1);
          tailTime = DateTime(now.year, DateTime.march, 31);
          break;
        case 'Q2':
          headTime = DateTime(now.year, DateTime.april, 1);
          tailTime = DateTime(now.year, DateTime.june, 30);
          break;
        case 'Q3':
          headTime = DateTime(now.year, DateTime.july, 1);
          tailTime = DateTime(now.year, DateTime.september, 30);
          break;
        case 'Q4':
          headTime = DateTime(now.year, DateTime.october, 1);
          tailTime = DateTime(now.year, DateTime.december, 31);
          break;
        default:
      }
    }

    return DateTimeRange(start: headTime, end: tailTime);
  }

  static DateTimeRange _getTimeRangeBaseOnYear(String chooseTab) {
    var chooseTime = chooseTab;

    var tempt = int.tryParse(chooseTime);
    if (tempt == null) {
      if (chooseTime == 'LAST YEAR'.tr) {
        chooseTime = (DateTime.now().year - 1).toString();
      } else if (chooseTime == 'THIS YEAR'.tr) {
        chooseTime = (DateTime.now().year).toString();
      } else {
        chooseTime = (DateTime.now().year + 1).toString();
      }
    }

    DateTime startDate = DateTime(int.parse(chooseTime), DateTime.january, 1);
    DateTime endDate = DateTime(startDate.year, DateTime.december, 31);
    return DateTimeRange(start: startDate, end: endDate);
  }
}
