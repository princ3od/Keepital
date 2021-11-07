import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:keepital/app/core/values/assets.gen.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/modules/first_wallet/widgets/category_picker.dart';
import 'package:keepital/app/routes/pages.dart';

class FirstWalletScreenController extends GetxController {
  var _walletProvider = WalletProvider();
  final walletNameTextEditingController = TextEditingController();
  final currencyTextEditingController = TextEditingController();
  final currencyId = "".obs;
  final iconIdAssetGenImage = Assets.inAppIconWalletDefault.obs;
  final currencySymbol = "".obs;
  final isLoading = false.obs;
  handAddFirstWallet() async {
    try {
      var newWallet = _createFirstWallet();
      isLoading.value = true;
      if (newWallet != null) {
        var result = await _walletProvider.add(newWallet);
        DataService.currentUser?.wallets[result.id!] = result;
        Get.snackbar("Warning", "Your's first wallet has been added");
        Get.offAllNamed(Routes.home);
      } else {
        Get.snackbar("Error", "Your's input data is invalid");
      }
    } on Exception catch (_) {
      Get.snackbar("Error", "Something go wrong, please wait a minute and try again.");
    } finally {
      isLoading.value = false;
    }
  }

  void showCurrencyPickerOfWalletScreen(BuildContext context) {
    return showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        currencyTextEditingController.text = currency.name;
        currencyId.value = currency.code;
        currencySymbol.value = currency.symbol;
      },
    );
  }

  void showIconCategoryPicker() {
    Get.bottomSheet(CategoryPicker(
      onPicked: (assetGenImageValue) {
        iconIdAssetGenImage.value = assetGenImageValue;
      },
    ));
  }

  Wallet? _createFirstWallet() {
    var newWallet = Wallet(
      null,
      name: walletNameTextEditingController.text,
      amount: 0.0,
      currencyId: this.currencyId.value,
      iconId: iconIdAssetGenImage.value.path,
      currencySymbol: this.currencySymbol.value,
    );
    if (newWallet.checkIsValidInputDataToAdd()) {
      return newWallet;
    } else {
      return null;
    }
  }

  void clearCache() {
    walletNameTextEditingController.text = "";
    currencyTextEditingController.text = "";
    currencyId.value = "";
    iconIdAssetGenImage.value = Assets.iconsCalendar; //default
    currencySymbol.value = "";
    isLoading.value = false;
  }
}
