import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/core/values/assets.gen.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/modules/add_wallet/widgets/category_picker.dart';
import 'package:keepital/app/modules/my_wallets/my_wallets_controller.dart';
import 'package:keepital/app/routes/pages.dart';

class AddWalletController extends GetxController {
  var _walletProvider = WalletProvider();
  var walletNameTextEditingController = TextEditingController(text: 'Cash');
  var currencyTextEditingController = TextEditingController();
  var currencyId = "".obs;
  var walletIcon = Assets.inAppIconWalletDefault.obs;
  var currencySymbol = "".obs;
  final walletAmountTextEditingController = TextEditingController();
  final MyWalletsController _walletsController = Get.find<MyWalletsController>();
  var isLoading = false.obs;

  handAddFirstWallet() async {
    try {
      isLoading.value = true;
      await Future.delayed(AppValue.delayTime);
      var newWallet = _createFirstWallet();
      if (newWallet.isValid) {
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

  void showWalletCurrencyPicker(BuildContext context) {
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
      favorite: AppValue.favoritedCurrencies,
    );
  }

  void showIconCategoryPicker() {
    Get.bottomSheet(CategoryPicker(
      onPicked: (assetGenImageValue) {
        walletIcon.value = assetGenImageValue;
      },
    ));
  }

  Wallet _createFirstWallet() {
    return Wallet(
      null,
      name: walletNameTextEditingController.text,
      amount: 0.0,
      currencyId: this.currencyId.value,
      iconId: walletIcon.value.path,
      currencySymbol: this.currencySymbol.value,
    );
  }

  void clearInputData() {
    walletNameTextEditingController.text = "";
    currencyTextEditingController.text = "";
    currencyId.value = "";
    walletIcon.value = Assets.inAppIconWalletDefault;
    currencySymbol.value = "";
    isLoading.value = false;
    walletAmountTextEditingController.clear();
  }

  handAddWallet() async {
    try {
      var newWallet = _createWallet();
      isLoading.value = true;
      if (newWallet != null) {
        var result = await _walletProvider.add(newWallet);
        DataService.currentUser?.wallets[result.id!] = result;
        Get.snackbar("Warning", "Your's first wallet has been added");
        clearInputData();
      } else {
        Get.snackbar("Error", "Your's input data is invalid");
      }
    } on Exception catch (_) {
      Get.snackbar("Error", "Something go wrong, please wait a minute and try again.");
    } finally {
      isLoading.value = false;
    }
  }

  Wallet? _createWallet() {
    try {
      var newWallet = Wallet(null, name: walletNameTextEditingController.text, amount: double.parse(walletAmountTextEditingController.text), currencyId: currencyId.value, iconId: walletIcon.value.path, currencySymbol: currencySymbol.value);
      if (newWallet.isValid) {
        return newWallet;
      } else {
        return null;
      }
    } on Exception {
      return null;
    }
  }

  onClosed() {
    _walletsController.fetchUserWallets();
  }
}
