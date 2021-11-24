import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/theme/app_theme.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/global_widgets/clickable_list_item.dart';
import 'package:keepital/app/global_widgets/section_panel.dart';
import 'package:keepital/app/global_widgets/textfield_with_icon_picker_item.dart';
import 'package:keepital/app/modules/add_wallet/add_wallet_controller.dart';
import 'package:keepital/app/routes/pages.dart';

class AddWalletScreen extends StatelessWidget {
  AddWalletScreen({Key? key, this.wallet}) : super(key: key) {
    if (wallet != null) {
      _controller.walletNameTextEditingController.text = wallet!.name;
      _controller.walletAmount.value = wallet!.amount.toDouble();
      _controller.walletAmountTextEditingController.text = wallet!.amount.toString();
      _controller.walletIconPath.value = wallet!.iconId;
      _controller.currencySymbol = wallet!.currencySymbol;
      _controller.currencyId = wallet!.currencyId;
      _controller.currencyName.value = CurrencyService().findByCode(wallet!.currencyId)!.name;
      _controller.oldWallet = wallet;
    }
  }
  final AddWalletController _controller = Get.find<AddWalletController>();
  final Wallet? wallet;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.clear_outlined,
            color: AppTheme.currentTheme.iconTheme.color,
          ),
          onPressed: () {
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
              await _controller.onSave(context);
            },
            child: Text(
              'SAVE',
            ),
          )
        ],
        elevation: 1,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Obx(
            () => SectionPanel(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  TextfieldWithIconPicker(
                    textEditingController: _controller.walletNameTextEditingController,
                    onPressed: () => _controller.selectIcon(context),
                    iconId: _controller.walletIconPath.value,
                  ),
                  ClickableListItem(
                    enabled: (wallet == null) ? true : false,
                    hintText: 'currency'.tr,
                    leading: Icon(
                      FontAwesomeIcons.dollarSign,
                    ),
                    text: _controller.currencyName.value,
                    onPressed: () => _controller.showWalletCurrencyPicker(context),
                  ),
                  ClickableListItem(
                    text: _controller.walletAmount.value.readable,
                    textSize: 24,
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      var result = await Get.toNamed(Routes.amountKeyboard, arguments: _controller.walletAmount.toString());
                      if (result != null) {
                        _controller.walletAmount.value = double.parse(result);
                        _controller.walletAmountTextEditingController.text = result;
                      }
                    },
                    hintText: 'Wallet amount'.tr,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
