import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/image_view.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/global_widgets/category_selector.dart';
import 'package:keepital/app/modules/add_category/add_category_controller.dart';
import 'package:keepital/app/modules/add_category/widgets/add_category_topbar.dart';
import 'package:keepital/app/global_widgets/clickable_list_item.dart';
import 'package:keepital/app/routes/pages.dart';

class AddCategoryScreen extends StatelessWidget {
  AddCategoryScreen({Key? key}) : super(key: key) {
    _controller.categoryType = Rx(Get.arguments);
  }

  final AddCategoryController _controller = Get.find<AddCategoryController>();
  final nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddCategoryTopBar(
        onSaveTap: () {
          if (isValidData()) {
            _controller.onSave(nameTextController.text);
            Navigator.pop(context);
          }
        },
      ),
      body: Wrap(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            color: Theme.of(context).backgroundColor,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Obx(() => InkWell(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 14,
                                    ),
                                    ImageView(
                                      _controller.icon.value,
                                      size: 30,
                                    ),
                                    Divider(color: Colors.grey[350], thickness: 2)
                                  ],
                                ),
                                onTap: () async {
                                  final result = await Get.toNamed(Routes.selectIcon);
                                  if (null != result) {
                                    _controller.icon.value = result;
                                  }
                                },
                              )),
                        ),
                        Expanded(
                          flex: 10,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 2),
                            child: TextField(
                              controller: nameTextController,
                              style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                hintText: 'Category name'.tr,
                                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey[350]),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Row(
                        children: [
                          Radio(
                              activeColor: Theme.of(context).primaryColor,
                              value: CategoryType.income,
                              groupValue: _controller.categoryType.value,
                              onChanged: (CategoryType? type) {
                                if (type != null) {
                                  _controller.categoryType.value = type;
                                }
                              }),
                          Text(
                            'Income'.tr,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Radio(
                              activeColor: Theme.of(context).primaryColor,
                              value: CategoryType.expense,
                              groupValue: _controller.categoryType.value,
                              onChanged: (CategoryType? type) {
                                if (type != null) {
                                  _controller.categoryType.value = type;
                                }
                              }),
                          Text(
                            'Expense'.tr,
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      ),
                    )),
                Obx(() => ClickableListItem(
                    leading: Icon(Icons.category),
                    text: _controller.parentName.value,
                    hintText: 'Parent category'.tr,
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _controller.parent = await showCategoriesModalBottomSheet(context);
                      _controller.parentName.value = _controller.parent?.name ?? '';
                    }))
              ],
            ),
          )
        ],
      ),
    );
  }

  bool isValidData() {
    if (nameTextController.text.isBlank!) {
      Get.snackbar('', '', titleText: Text('Info'.tr), messageText: Text('Please fill out the name field'.tr));
      return false;
    }
    return true;
  }
}
