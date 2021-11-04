import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/providers/category_provider.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/add_transaction/widgets/category_item.dart';
import 'package:keepital/app/modules/category/categories_controller.dart';
import 'package:keepital/app/modules/category/widgets/add_category_button.dart';
import 'package:keepital/app/modules/category/widgets/categories_topbar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with TickerProviderStateMixin {
  final CategoriesController _controller = Get.find<CategoriesController>();

  @override
  Widget build(BuildContext context) {
    _controller.tabController = TabController(length: 3, vsync: this, initialIndex: 1).obs;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CategoriesTopBar(),
      body: FutureBuilder(
        future: CategoryProvider().fetchAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return createTabBarView(context, snapshot);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget createTabBarView(BuildContext context, AsyncSnapshot<Object?> snapshot) {
    var catList = snapshot.data as List<Category>;
    List<Category> expenseList = [];
    List<Category> incomeList = [];
    catList.forEach((element) {
      if (element.type == CategoryType.income) {
        incomeList.add(element);
      } else if (element.type == CategoryType.expense) {
        expenseList.add(element);
      }
    });

    return TabBarView(
        controller: _controller.tabController.value,
        children: _controller.tabs.map((element) {
          if (element.data == 'EXPENSE'.tr) {
            return ListView.builder(
                itemCount: expenseList.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return AddCategoryButton(text: 'NEW EXPENSE CATEGORY',);

                  return CategoryItem(category: expenseList[index - 1]);
                });
          } else if (element.data == 'INCOME'.tr) {
            return ListView.builder(
                itemCount: incomeList.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return AddCategoryButton(text: 'NEW INCOME CATEGORY',);

                  return CategoryItem(category: incomeList[index - 1]);
                });
          } else {
            return Center();
          }
        }).toList());
  }
}
