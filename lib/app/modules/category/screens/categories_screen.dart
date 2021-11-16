import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/global_widgets/category_item.dart';
import 'package:keepital/app/modules/category/categories_controller.dart';
import 'package:keepital/app/modules/category/widgets/add_category_button.dart';
import 'package:keepital/app/modules/category/widgets/categories_topbar.dart';
import 'package:keepital/app/modules/category/widgets/category_container.dart';
import 'package:keepital/app/routes/pages.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with TickerProviderStateMixin {
  final CategoriesController _controller = Get.find<CategoriesController>();
  bool isCategorySelector = Get.arguments;

  @override
  void initState() {
    super.initState();
    _controller.tabController = TabController(length: 3, vsync: this, initialIndex: 1).obs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CategoriesTopBar(),
        body: Obx(() => _controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : createTabBarView(context, _controller.parentCatList)));
  }

  Widget createTabBarView(BuildContext context, List<Category> catList) {
    return Obx(() => TabBarView(
        controller: _controller.tabController.value,
        children: _controller.tabs.map((element) {
          if (element.data == 'EXPENSE'.tr) {
            return createListView(context, _controller.expenseList, 'NEW EXPENSE CATEGORY');
          } else if (element.data == 'INCOME'.tr) {
            return createListView(context, _controller.incomeList, 'NEW INCOME CATEGORY');
          } else {
            return createListView(context, _controller.debtNLoanList, 'NEW CATEGORY');
          }
        }).toList()));
  }

  Widget createListView(BuildContext context, List<Category> catList, String buttonText) {
    return ListView.builder(
        itemCount: catList.length + 1,
        itemBuilder: (context, index) {
          if (index == 0)
            return Visibility(
              visible: !isCategorySelector,
              child: AddCategoryButton(
                text: buttonText,
                onTap: () {
                  Get.toNamed(Routes.addCategory, arguments: CategoryType.expense);
                },
              ),
            );

          var cat = catList[index - 1];
          var subCat = _controller.subcategories[cat.id];
          return CategoryContainer(
            parent: CategoryItem(
              category: cat,
              onTap: categoryOnTap,
            ),
            children: List.generate(subCat?.length ?? 0, (index) {
              return CategoryItem(
                category: subCat![index],
                onTap: categoryOnTap,
              );
            }),
          );
        });
  }

  void categoryOnTap(Category category) {
    if (isCategorySelector) {
      Get.back<Category>(result: category);
    } else {}
  }
}
