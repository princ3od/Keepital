import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/image_view.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/core/values/assets.gen.dart';
import 'package:keepital/app/data/models/budget.dart';
import 'package:keepital/app/global_widgets/clickable_list_item.dart';
import 'package:keepital/app/global_widgets/common_app_bar.dart';
import 'package:keepital/app/global_widgets/icon_textfield.dart';
import 'package:keepital/app/global_widgets/section_panel.dart';
import 'package:keepital/app/modules/budget/add_budget_controller.dart';
import 'package:keepital/app/modules/home/widgets/wallet_item.dart';
import 'package:keepital/app/routes/pages.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddBudgetScreen extends StatelessWidget {
  AddBudgetScreen({Key? key, this.budget}) : super(key: key) {
    if (isEditing) {
      controller.loadData(budget!);
    }
  }
  final controller = Get.put(AddBudgetController());
  final Budget? budget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          title: 'Add budget'.tr,
          onSaveTap: () => controller.onSaveTap(budget),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            SectionPanel(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Obx(() => ClickableListItem(
                        leading: controller.categoryIconId.value.isEmpty
                            ? Assets.iconsUnknown.image()
                            : ImageView(
                                controller.categoryIconId.value,
                                size: 24,
                                color: categoryIconColor(context),
                              ),
                        hintText: 'hint_category'.tr,
                        text: controller.strCategory.value,
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          var category = await Get.toNamed(Routes.categorySelector4Budget, arguments: true);

                          controller.onSelectCategory(category);
                        },
                      )),
                  IconTextField(
                    textEditingController: controller.amountTextController,
                    keyboardType: TextInputType.number,
                    hintText: 'Goal'.tr,
                  ),
                  Obx(() => ClickableListItem(
                        leading: Image.asset(AssetStringsPng.calendar, color: Theme.of(context).iconTheme.color),
                        text: controller.strDate.value,
                        onPressed: () async => await controller.onTimeRangeTap(context),
                      )),
                  Obx(() => ClickableListItem(
                        enabled: !isEditing,
                        leading: Icon(Icons.account_balance_wallet),
                        hintText: 'hint_wallet'.tr,
                        text: controller.walletName.value,
                        onPressed: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          showWalletsModalBottomSheet(context);
                        },
                      )),
                ],
              ),
            ),
            repeatWidget(context)
          ],
        ));
  }

  void showWalletsModalBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
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
                  'Select wallet'.tr,
                  style: Theme.of(context).textTheme.headline5,
                ),
                LimitedBox(
                  maxHeight: 160,
                  child: ListView.builder(
                      itemExtent: 50.0,
                      shrinkWrap: true,
                      itemCount: controller.wallets.length,
                      itemBuilder: (BuildContext context, int index) {
                        String key = controller.wallets.keys.elementAt(index);
                        return Obx(() => WalletItem(
                              wallet: controller.wallets[key]!,
                              selectedId: controller.walletId.value,
                              onTap: () {
                                controller.walletId.value = key;
                                controller.walletName.value = controller.wallets[key]!.name;
                              },
                            ));
                      }),
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
  }

  Widget repeatWidget(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.width * 0.05),
        SectionPanel(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 1,
                child: Obx(() => Checkbox(
                      checkColor: Theme.of(context).backgroundColor,
                      activeColor: Theme.of(context).iconTheme.color!.withOpacity(0.7),
                      value: controller.repeat.value,
                      onChanged: (value) {
                        controller.repeat.value = value!;
                      },
                    )),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Repeat this budget'.tr, style: Theme.of(context).textTheme.bodyText1),
                    Text(
                      'Budget will renew automatically'.tr,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Color.fromARGB(127, 0, 0, 0)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Color? categoryIconColor(BuildContext context) => controller.categoryIconId.value == Assets.iconsUnknown.path ? Theme.of(context).iconTheme.color : null;
  bool get isEditing => Get.currentRoute == Routes.editBudget;
}
