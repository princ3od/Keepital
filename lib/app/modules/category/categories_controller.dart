import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  late RxList<Text> tabs;
  late Rx<TabController> tabController;

  CategoriesController() {
    tabs = initTabBar().obs;
  }

  List<Text> initTabBar() {
    return [Text('DEBT & LOAN'.tr), Text('EXPENSE'.tr), Text('INCOME'.tr)];
  }
}
