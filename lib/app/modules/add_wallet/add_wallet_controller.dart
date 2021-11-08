import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/modules/first_wallet/first_wallet_controller.dart';
import 'package:keepital/app/modules/my_wallets/my_wallets_controller.dart';

class AddWalletController extends GetxController {
  FirstWalletScreenController firstWalletScreenController = new FirstWalletScreenController();
  final walletAmountTextEditingController = TextEditingController();
  final MyWalletsController _walletsController = Get.find<MyWalletsController>();
  final isLoading = false.obs;
  final _walletProvider = WalletProvider();

  handAddWallet() async {
    try {
      var newWallet = _createWallet();
      isLoading.value = true;
      if (newWallet != null) {
        var result = await _walletProvider.add(newWallet);
        DataService.currentUser?.wallets[result.id!] = result;
        Get.snackbar("Warning", "Your's first wallet has been added");
        _clearCache();
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
      var newWallet = Wallet(null,
          name: firstWalletScreenController.walletNameTextEditingController.text,
          amount: double.parse(walletAmountTextEditingController.text),
          currencyId: firstWalletScreenController.currencyId.value,
          iconId: firstWalletScreenController.walletIcon.value,
          currencySymbol: firstWalletScreenController.currencySymbol.value);
      if (newWallet.isValid) {
        return newWallet;
      } else {
        return null;
      }
    } on Exception {
      return null;
    }
  }

  _clearCache() {
    firstWalletScreenController.clearInputData();
    walletAmountTextEditingController.clear();
  }

  onClosed() {
    _walletsController.fetchUserWallets();
  }
}
