import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';

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
        if (result != null) {
          Get.snackbar("Warning", "Your's first wallet has been added");
        } else {
          Get.snackbar("Error", "Your's input data is invalid");
        }
      }
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

  bool _checkIsValidInputDataToAdd(Wallet obj) {
    if (obj == null || obj.name == null || obj.name == "" || obj.amount == null || obj.currencyId == null || obj.currencyId == "" || obj.iconId == null) {
      return false;
    }
    return true;
  }

  Wallet? _createFirstWallet() {
    var newWallet = Wallet(null, name: walletNameTextEditingController.text, amount: 0.0, currencyId: currencyCode.value, iconId: currencyIcon.value);
    if (_checkIsValidInputDataToAdd(newWallet)) {
      return newWallet;
    } else {
      return null;
    }
  }
}
