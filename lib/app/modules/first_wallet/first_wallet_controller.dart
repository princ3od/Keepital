import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/routes/pages.dart';

class FirstWalletScreenController extends GetxController {
  var _walletProvider = WalletProvider();
  final walletNameTextEditingController = TextEditingController();
  final currencyTextEditingController = TextEditingController();
  final currencyCode = "".obs;
  final currencyIcon = "".obs;
  final isLoading = false.obs;
  handAddFirstWallet() async {
    try {
      var newWallet = _createFirstWallet();
      isLoading.value = true;
      if (newWallet != null) {
        var result = await _walletProvider.add(newWallet);
        DataService.currentUser?.wallets.add(result);
        Get.snackbar("Warning", "Your's first wallet has been added");
        Get.toNamed(Routes.home);
      } else {
        Get.snackbar("Error", "Your's input data is invalid");
      }
    } on Exception catch (_) {
      Get.snackbar(
          "Error", "Something go wrong, please wait a minute and try again.");
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
        currencyCode.value = currency.code;
        currencyIcon.value = currency.symbol;
      },
    );
  }

  Wallet? _createFirstWallet() {
    var newWallet = Wallet(null,
        name: walletNameTextEditingController.text,
        amount: 0.0,
        currencyId: currencyCode.value,
        iconId: currencyIcon.value);
    if (newWallet.checkIsValidInputDataToAdd()) {
      return newWallet;
    } else {
      return null;
    }
  }
}
