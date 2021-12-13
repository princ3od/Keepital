import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/providers/category_provider.dart';
import 'package:keepital/app/enums/app_enums.dart';

class CategoriesController extends GetxController {
  late RxList<Text> tabs;
  late Rx<TabController> tabController;
  late RxList<Category> parentCatList;
  RxBool isLoading = false.obs;

  List<Category> debtNLoanList = [];
  List<Category> expenseList = [];
  List<Category> incomeList = [];
  Map<String, List<Category>> subcategories = {};

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();
    await loadData();
    isLoading.value = false;
  }

  Future loadData() async {
    parentCatList = (await getParentCategories).obs;
    parentCatList.forEach((element) {
      print(element.iconId);
      if (element.isDebtNLoan) {
        debtNLoanList.add(element);
      } else if (element.type == CategoryType.income) {
        incomeList.add(element);
      } else if (element.type == CategoryType.expense) {
        expenseList.add(element);
      }
    });

    await loadSubcategories();
  }

  Future loadSubcategories() async {
    for (var item in parentCatList) {
      var catList = await CategoryProvider().conditionalFetch(item.id!);
      subcategories[item.id!] = catList;
    }
  }

  Future refreshData() async {
    isLoading.value = true;
    expenseList = [];
    incomeList = [];
    debtNLoanList = [];

    parentCatList.value = await getParentCategories;
    parentCatList.forEach((element) {
      if (element.isDebtNLoan) {
        debtNLoanList.add(element);
      } else if (element.type == CategoryType.income) {
        incomeList.add(element);
      } else if (element.type == CategoryType.expense) {
        expenseList.add(element);
      }
    });
    await loadSubcategories();
    isLoading.value = false;
  }

  Future<List<Category>> get getParentCategories => CategoryProvider().conditionalFetch('');

  void initTabBar({bool hideIncome = false}) {
    tabs = hideIncome ? [Text('DEBT & LOAN'.tr), Text('EXPENSE'.tr)].obs : [Text('DEBT & LOAN'.tr), Text('EXPENSE'.tr), Text('INCOME'.tr)].obs;
  }
}
