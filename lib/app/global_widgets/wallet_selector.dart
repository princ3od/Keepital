import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/modules/home/widgets/wallet_item.dart';
import 'package:keepital/app/routes/pages.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showWalletsModalBottomSheet(BuildContext context, {required String? selectedId, Function(String)? onSelectWallet}) {
  RxString observableSelectedId = (selectedId ?? '').obs;
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
              Obx(() => WalletItem(
                  wallet: DataService.total,
                  selectedId: observableSelectedId.value,
                  onTap: () {
                    observableSelectedId.value = '';
                    onSelectWallet?.call('');
                    Get.back();
                  })),
              Divider(
                color: Theme.of(context).iconTheme.color,
                thickness: 1,
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
                            selectedId: observableSelectedId.value,
                            onTap: () {
                              observableSelectedId.value = key;
                              onSelectWallet?.call(key);
                              Get.back();
                            },
                          ));
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: OutlinedButton(
                  onPressed: () async {
                    Get.back();
                    Get.toNamed(Routes.myWallets);
                  },
                  child: Text('Go to My Wallets'.tr),
                  style: Theme.of(context).outlinedButtonTheme.style,
                ),
              )
            ],
          ),
        ]),
      ),
    ),
  );
}

Map<String, Wallet> get wallets => DataService.currentUser!.wallets;
