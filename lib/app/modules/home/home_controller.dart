import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_strings.dart';
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
    pageController.animateToPage(_pageIndex,
        duration: Duration(milliseconds: 600),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  bool needShowAppBar() {
    final _pageIndex = _getPageIndexFromTabIndex(tabIndex.value);
    return (_pageIndex < AppValue.unusedTabIndex);
  }
}
