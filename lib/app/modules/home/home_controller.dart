import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keepital/app/core/values/app_value.dart';

class HomeController extends GetxController {
  final PageController pageController = PageController();

  var tabIndex = 0.obs;

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

  List<Text> initTabBar(int choosedTimeRange, {var extraInfo}) {
    if (choosedTimeRange == 3) {
      return List.generate(20, (index) {
        var now = DateTime.now();
        if (index == 17) {
          return Text('LAST MONTH');
        } else if (index == 18) {
          return Text('THIS MONTH');
        } else if (index == 19) {
          return Text('FUTURE');
        } else {
          var date = DateTime(now.year, now.month - (18 - index), now.day);
          String dateDisplay = DateFormat('MM/yyyy').format(date);
          return Text(dateDisplay);
        }
      });
    } else if (choosedTimeRange == 1) {
      return List.generate(20, (index) {
        var now = DateTime.now();
        if (index == 17) {
          return Text('YESTERDAY');
        } else if (index == 18) {
          return Text('TODAY');
        } else if (index == 19) {
          return Text('FUTURE');
        } else {
          var date = DateTime(now.year, now.month, now.day - (18 - index));
          String dateDisplay = DateFormat('dd MMMM yyyy').format(date);
          return Text(dateDisplay);
        }
      });
    } else if (choosedTimeRange == 2) {
      return List.generate(20, (index) {
        if (index == 17) {
          return Text('LAST WEEK');
        } else if (index == 18) {
          return Text('THIS WEEK');
        } else if (index == 19) {
          return Text('FUTURE');
        } else {
          var firstDateInAWeek = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)).subtract(Duration(days: 7 * (18 - index)));
          String firstDateDisplay = DateFormat('dd/MM').format(firstDateInAWeek);

          var lastDateInAWeek = firstDateInAWeek.add(Duration(days: 6));
          String lastDateDisplay = DateFormat('dd/MM').format(lastDateInAWeek);

          return Text(firstDateDisplay + ' - ' + lastDateDisplay);
        }
      });
    } else if (choosedTimeRange == 4) {
      var now = DateTime.now();
      int year = now.year;
      int initQuarter = ((now.month + 2) / 3).toInt();
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
          return Text('FUTURE');
        } else {
          // String dateDisplay = DateFormat('yyyy').format(date);
          String display = list[index];
          return Text(display);
        }
      });
    } else if (choosedTimeRange == 5) {
      return List.generate(20, (index) {
        var now = DateTime.now();
        if (index == 17) {
          return Text('LAST YEAR');
        } else if (index == 18) {
          return Text('THIS YEAR');
        } else if (index == 19) {
          return Text('FUTURE');
        } else {
          var date = DateTime(now.year, now.month, now.day - (18 - index));
          String dateDisplay = DateFormat('yyyy').format(date);
          return Text(dateDisplay);
        }
      });
    } else if (choosedTimeRange == 6) {
      return List.generate(1, (index) {
        return Text('All transactions');
      });
    } else {
      return List.generate(1, (index) {
        return Text(extraInfo);
      });
    }
  }
}
