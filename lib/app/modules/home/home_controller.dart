import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/keepital_user.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/exchange_rate_provider.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/routes/pages.dart';
import 'package:tuple/tuple.dart';

class HomeController extends GetxController {
  Wallet total = Wallet('', name: 'Total'.tr, amount: DataService.currentUser!.amount, currencyId: DataService.currentUser!.currencyId, iconId: '', currencySymbol: DataService.currentUser!.currencySymbol);
  RxBool isLoading = false.obs;
  late RxList<TransactionModel> transList;
  final PageController pageController = PageController();
  late Rx<TabController> tabController;

  Map<String, Wallet> wallets = DataService.currentUser!.wallets;
  late Rx<Wallet> currentWallet;

  var tabIndex = 0.obs;

  var selectedTimeRange = TimeRange.month.obs;
  late RxList<Text> tabs;
  RxBool viewByDate = true.obs;

  Map<Tuple2<String, String>, double> exchangeRates = {};


  HomeController() {
    currentWallet = total.obs;
    tabs = initTabBar(selectedTimeRange.value).obs;
  }

  KeepitalUser get curUser => DataService.currentUser!;

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();
    transList = (await TransactionProvider().fetchAll()).obs;
    await loadExchangeRates();
    isLoading.value = false;
  }

  bool get isTotalWallet => currentWallet.value.id == '';

  Future loadExchangeRates() async {
    for (var w1 in wallets.values) {
      exchangeRates[Tuple2(w1.currencyId, total.currencyId)] = (await ExchangeRate.getExchangeRate(w1.currencyId, total.currencyId)).rate;
      exchangeRates[Tuple2(total.currencyId, w1.currencyId)] = (await ExchangeRate.getExchangeRate(total.currencyId, w1.currencyId)).rate;
    }
  }

  Future reloadTransList() async {
    isLoading.value = true;
    transList.value = await TransactionProvider().fetchAll();
    isLoading.value = false;
  }

  void onCurrentWalletChange(String id) {
    currentWallet.value = wallets[id] ?? total;
    DataService.currentUser!.currentWallet = id;
  }

  onTabChanged(int _tabIndex) {
    if (_tabIndex == AppValue.unusedTabIndex) {
      return;
    }
    tabIndex.value = _tabIndex;
    final _pageIndex = _getPageIndexFromTabIndex(_tabIndex);
    _moveToPage(_pageIndex);
  }

  onPageChanged(int _pageIndex) {
    final _tabIndex = _getTabIndexFromPageIndex(_pageIndex);
    tabIndex.value = _tabIndex;
  }

  int _getPageIndexFromTabIndex(int _tabIndex) {
    if (_tabIndex < AppValue.unusedTabIndex) {
      return _tabIndex;
    }
    return _tabIndex - 1;
  }

  int _getTabIndexFromPageIndex(int _pageIndex) {
    if (_pageIndex < AppValue.unusedTabIndex) {
      return _pageIndex;
    }
    return _pageIndex + 1;
  }

  void _moveToPage(int _pageIndex) {
    pageController.animateToPage(
      _pageIndex,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  bool needShowAppBar() {
    final _pageIndex = _getPageIndexFromTabIndex(tabIndex.value);
    return (_pageIndex < AppValue.unusedTabIndex);
  }

  List<Text> initTabBar(TimeRange choosedTimeRange) {
    if (choosedTimeRange == TimeRange.month) {
      return List.generate(20, (index) {
        var now = DateTime.now();
        if (index == 17)
          return Text('LAST MONTH'.tr);
        else if (index == 18)
          return Text('THIS MONTH'.tr);
        else if (index == 19)
          return Text('FUTURE'.tr);
        else {
          var date = DateTime(now.year, now.month - (18 - index), 1);
          String dateDisplay = date.shortMonth;
          return Text(dateDisplay);
        }
      });
    } else if (choosedTimeRange == TimeRange.day) {
      return List.generate(20, (index) {
        var now = DateTime.now();
        if (index == 17)
          return Text('YESTERDAY'.tr);
        else if (index == 18)
          return Text('TODAY'.tr);
        else if (index == 19)
          return Text('FUTURE'.tr);
        else {
          var date = DateTime(now.year, now.month, now.day - (18 - index));
          String dateDisplay = date.fullDate;
          return Text(dateDisplay);
        }
      });
    } else if (choosedTimeRange == TimeRange.week) {
      return List.generate(20, (index) {
        if (index == 17)
          return Text('LAST WEEK'.tr);
        else if (index == 18)
          return Text('THIS WEEK'.tr);
        else if (index == 19)
          return Text('FUTURE'.tr);
        else {
          var firstDateInAWeek = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)).subtract(Duration(days: 7 * (18 - index)));
          String firstDateDisplay = firstDateInAWeek.dayInMonth;

          var lastDateInAWeek = firstDateInAWeek.add(Duration(days: 6));
          String lastDateDisplay = lastDateInAWeek.dayInMonth;

          return Text(firstDateDisplay + ' - ' + lastDateDisplay);
        }
      });
    } else if (choosedTimeRange == TimeRange.quarter) {
      var now = DateTime.now();
      int year = now.year;
      int initQuarter = (now.month + 2) ~/ 3;
      int k = 0;

      List<String> list = [];

      for (var i = 0; i < 20; i++) {
        var q = initQuarter - i + 4 * k + 1;
        list.add('Q$q $year');
        if (q == 1) {
          k = k + 1;
          year = year - 1;
        }
      }
      list = list.reversed.toList();

      return List.generate(20, (index) {
        if (index == 19) {
          return Text('FUTURE'.tr);
        } else {
          String display = list[index];
          return Text(display);
        }
      });
    } else if (choosedTimeRange == TimeRange.year) {
      return List.generate(20, (index) {
        var now = DateTime.now();
        if (index == 17)
          return Text('LAST YEAR'.tr);
        else if (index == 18)
          return Text('THIS YEAR'.tr);
        else if (index == 19)
          return Text('FUTURE'.tr);
        else {
          var date = DateTime(now.year - (18 - index), now.month, 1);
          String dateDisplay = date.fullYear;
          return Text(dateDisplay);
        }
      });
    } else {
      return List.generate(1, (index) {
        return Text('ALL TRANSACTIONS'.tr);
      });
    }
  }

  List<TransactionModel> filterTransBasedOnTime(List<TransactionModel> transList, String choseTab) {
    switch (selectedTimeRange.value) {
      case TimeRange.month:
        return filterTransBasedOnMonth(transList, choseTab);
      case TimeRange.day:
        return filterTransBasedOnDay(transList, choseTab);
      case TimeRange.week:
        return filterTransBasedOnWeek(transList, choseTab);
      case TimeRange.quarter:
        return filterTransBasedOnQuarter(transList, choseTab);
      case TimeRange.year:
        return filterTransBasedOnYear(transList, choseTab);
      case TimeRange.all:
        return transList;
      default:
        return transList;
    }
  }

  List<TransactionModel> filterTransBasedOnMonth(List<TransactionModel> transList, String choseTab) {
    var chooseTime = choseTab.split('/');
    bool isFutureTab = false;

    if (chooseTime.length == 1) {
      chooseTime.clear();
      int nowMonth = DateTime.now().month;
      int nowYear = DateTime.now().year;

      if (choseTab == 'LAST MONTH'.tr) {
        chooseTime.add((nowMonth - 1).toString());
        chooseTime.add(nowYear.toString());
      } else if (choseTab == 'THIS MONTH'.tr) {
        chooseTime.add((nowMonth).toString());
        chooseTime.add(nowYear.toString());
      } else {
        chooseTime.add((nowMonth + 1).toString());
        chooseTime.add(nowYear.toString());
        isFutureTab = true;
      }
    }

    if (isFutureTab) {
      DateTime time = DateTime(int.parse(chooseTime[1]), int.parse(chooseTime[0]));

      transList = transList.where((element) => element.date.compareTo(time) > 0).toList();
      isFutureTab = false;
    } else {
      transList = transList.where((element) => element.date.month == int.parse(chooseTime[0]) && element.date.year == int.parse(chooseTime[1])).toList();
    }
    return transList;
  }

  List<TransactionModel> filterTransBasedOnDay(List<TransactionModel> transList, String choseTab) {
    bool isFutureTab = false;
    DateTime choseDate = DateTime.now();
    try {
      choseDate = choseTab.date();
    } catch (identifier) {
      if (choseTab == 'YESTERDAY'.tr) {
        choseDate = choseDate.subtract(Duration(days: 1));
      } else if (choseTab == 'TODAY'.tr) {
      } else {
        choseDate = choseDate.add(Duration(days: 1));
        isFutureTab = true;
      }
    }

    if (isFutureTab) {
      transList = transList.where((element) => element.date.compareTo(choseDate) > 0).toList();
      isFutureTab = false;
    } else {
      transList = transList.where((element) => element.date.isSameDate(choseDate)).toList();
    }
    return transList;
  }

  List<TransactionModel> filterTransBasedOnWeek(List<TransactionModel> transList, String choseTab) {
    List<String> chooseTime = [];
    chooseTime = choseTab.split(' - ');

    bool isFutureTab = false;

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

      if (choseTab == 'LAST WEEK'.tr) {
        headTime = firstDateInPast;
        tailTime = lastDateInPast;
      } else if (choseTab == 'THIS WEEK'.tr) {
        headTime = firstDatePresent;
        tailTime = lastDatePresent;
      } else {
        headTime = firstDateInFutre;
        isFutureTab = true;
      }
    } else {
      headDateList = chooseTime[0].split('/');
      headTime = DateTime(DateTime.now().year, int.parse(headDateList[1]), int.parse(headDateList[0]));
      tailTime = headTime.add(Duration(days: 6));
    }

    if (isFutureTab) {
      transList = transList.where((element) => element.date.compareTo(headTime) >= 0).toList();
      isFutureTab = false;
    } else {
      transList = transList.where((element) => element.date.compareTo(headTime) >= 0 && element.date.compareTo(tailTime) <= 0).toList();
    }

    return transList;
  }

  List<TransactionModel> filterTransBasedOnQuarter(List<TransactionModel> transList, String choseTab) {
    var chooseTime = choseTab.split(' ');

    DateTime headTime = DateTime.now();
    DateTime tailTime = DateTime.now();
    DateTime now = DateTime.now();
    bool isFutureTab = false;

    if (chooseTime.length == 1) {
      isFutureTab = true;
      var x = tabs[18].data!.split(' ');

      switch (x[0]) {
        case 'Q1':
          headTime = DateTime(now.year, DateTime.april);
          break;
        case 'Q2':
          headTime = DateTime(now.year, DateTime.july);
          break;
        case 'Q3':
          headTime = DateTime(now.year, DateTime.october);
          break;
        case 'Q4':
          headTime = DateTime(now.year + 1, DateTime.january);
          break;
        default:
      }
    } else {
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

    if (isFutureTab) {
      isFutureTab = false;
      transList = transList.where((element) => element.date.compareTo(headTime) >= 0).toList();
    } else {
      transList = transList.where((element) => element.date.compareTo(headTime) >= 0 && element.date.compareTo(tailTime) <= 0).toList();
    }

    return transList;
  }

  List<TransactionModel> filterTransBasedOnYear(List<TransactionModel> transList, String choseTab) {
    var chooseTime = choseTab;
    bool isFutureTab = false;

    var tempt = int.tryParse(chooseTime);
    if (tempt == null) {
      if (chooseTime == 'LAST YEAR'.tr) {
        chooseTime = (DateTime.now().year - 1).toString();
      } else if (chooseTime == 'THIS YEAR'.tr) {
        chooseTime = (DateTime.now().year).toString();
      } else {
        chooseTime = (DateTime.now().year + 1).toString();
        isFutureTab = true;
      }
    }

    if (isFutureTab) {
      transList = transList.where((element) => element.date.year >= int.parse(chooseTime)).toList();
      isFutureTab = false;
    } else {
      transList = transList.where((element) => element.date.year == int.parse(chooseTime)).toList();
    }

    return transList;
  }

  int getInitialTabBarIndex() => selectedTimeRange.value == TimeRange.all ? 0 : 18;
  int getTabBarLength() => selectedTimeRange.value == TimeRange.all ? 1 : 20;

  onAddTransaction() {
    Get.toNamed(Routes.addTransaction);
  }

  onUpdateWalletBalance() {
    String id = DataService.currentUser!.currentWallet;
    currentWallet.update((wallet) {
      wallet?.amount = curUser.wallets[id]!.amount;
    });
  }
}
