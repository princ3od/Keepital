import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/theme/app_theme.dart';
import 'package:keepital/app/modules/add_wallet/add_wallet_controller.dart';
import 'package:keepital/app/modules/add_wallet/widgets/underline_wallet_iconbutton.dart';

class AddWalletScreen extends StatelessWidget {
  final AddWalletController _controller = Get.find<AddWalletController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.clear_outlined,
              color: AppTheme.currentTheme.iconTheme.color,
            ),
            onPressed: () {
              _controller.onClosed();
              Get.back();
            },
          ),
          title: Text(
            "Add Wallet",
            style: AppTheme.currentTheme.textTheme.headline6,
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  await _controller.handAddWallet();
                },
                child: Text(
                  'SAVE',
                  style: AppTheme.currentTheme.textTheme.headline6,
                ))
          ],
          elevation: 1,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 13,
              ),
              Container(
                color: AppTheme.currentTheme.backgroundColor,
                height: 133,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      height: 40,
                      child: Row(
                        children: [
                          Obx(
                            () => UnderlineWalletIconButton(
                              onPresed: () {
                                _controller.firstWalletScreenController.showIconCategoryPicker();
                              },
                              assetGenImage: _controller.firstWalletScreenController.iconIdAssetGenImage.value,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _controller.firstWalletScreenController.walletNameTextEditingController,
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Wallet Name",
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => (_controller.firstWalletScreenController.currencySymbol.value == "")
                                ? Icon(
                                    Icons.money,
                                    size: 30,
                                  )
                                : SizedBox(
                                    width: 30,
                                    child: Text(
                                      _controller.firstWalletScreenController.currencySymbol.value,
                                      style: AppTheme.currentTheme.textTheme.headline6!.copyWith(fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextField(
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.left,
                              enabled: true,
                              showCursor: false,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Currency'.tr,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                              ),
                              onTap: () => _controller.firstWalletScreenController.showCurrencyPickerOfWalletScreen(context),
                              controller: _controller.firstWalletScreenController.currencyTextEditingController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 46,
                          ),
                          Expanded(
                            child: TextFormField(
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Wallet amount",
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                              ),
                              keyboardType: TextInputType.number,
                              controller: _controller.walletAmountTextEditingController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
