import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/providers/category_provider.dart';
import 'package:keepital/app/global_widgets/category_item.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<Category?> showCategoriesModalBottomSheet(BuildContext context) async {
  var categories = await CategoryProvider().conditionalFetch('');
  var selectedIndex = (-1).obs;

  await showMaterialModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
    ),
    builder: (context) => Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Wrap(children: [
          Column(
            children: [
              Text(
                'Select category'.tr,
                style: Theme.of(context).textTheme.headline5,
              ),
              LimitedBox(
                maxHeight: 160,
                child: Scrollbar(
                  isAlwaysShown: true,
                  child: ListView.builder(
                      itemExtent: 50.0,
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Obx(() => CategoryItem(
                              category: categories[index],
                              selectedIndex: selectedIndex.value,
                              index: index,
                              onTap: (category) {
                                selectedIndex.value = index;
                              },
                            ));
                      }),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ]),
      ),
    ),
  );

  return selectedIndex.value != -1 ? categories[selectedIndex.value] : null;
}
