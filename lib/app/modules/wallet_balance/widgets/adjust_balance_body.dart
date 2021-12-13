import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/global_widgets/clickable_list_item.dart';
import 'package:keepital/app/global_widgets/icon_textfield.dart';
import 'package:keepital/app/global_widgets/section_panel.dart';
import 'package:keepital/app/modules/home/widgets/wallet_item.dart';
import 'package:keepital/app/modules/wallet_balance/wallet_balance_controller.dart';
import 'package:keepital/app/routes/pages.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:keepital/app/core/utils/utils.dart';

class AdjustBalanceBody extends StatelessWidget {
  final controller = Get.find<WalletBalanceController>();

  @override
  Widget build(BuildContext context) {
    return SectionPanel(
      child: Column(
        children: [
          ClickableListItem(
            leading: Icon(Icons.account_balance_wallet),
            hintText: 'hint_wallet'.tr,
            text: controller.walletName.value,
            onPressed: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              showWalletsModalBottomSheet(context);
            },
          ),
          IconTextField(
            textEditingController: controller.currentBalanceController,
            hintText: 'Balance'.tr,
          ),
          ClickableListItem(
            text: num.tryParse(controller.currentBalanceController.text)?.readable ?? '',
            textSize: 20,
            onPressed: () async {
              FocusScope.of(context).requestFocus(new FocusNode());
              var result = await Get.toNamed(Routes.amountKeyboard, arguments: controller.currentBalanceController.text);
              if (result != null) {
                controller.currentBalanceController.text = result;
              }
            },
            hintText: 'Amount'.tr,
          ),
        ],
      ),
    );
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
                      itemCount: wallets.length,
                      itemBuilder: (BuildContext context, int index) {
                        String key = wallets.keys.elementAt(index);
                        return Obx(() => WalletItem(
                              wallet: wallets[key]!,
                              selectedId: controller.walletId.value,
                              onTap: () {
                                controller.walletId.value = key;
                                controller.walletName.value = wallets[controller.walletId]?.name ?? '';
                                controller.oldBalance = wallets[controller.walletId]?.amount ?? 0;
                                controller.currentBalanceController.text = controller.oldBalance.toString();
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

  Map<String, Wallet> get wallets => DataService.currentUser!.wallets;
}
