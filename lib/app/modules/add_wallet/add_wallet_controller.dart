import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/core/values/assets.gen.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/exchange_rate_provider.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/data/providers/user_provider.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/routes/pages.dart';

class AddWalletController extends GetxController {
  var _walletProvider = WalletProvider();
  var walletNameTextEditingController = TextEditingController(text: 'Cash');
  var currencyTextEditingController = TextEditingController();
  var currencyName = ''.obs;
  var currencyId = '';
  var walletIconPath = Assets.inAppIconWalletDefault.path.obs;
  var currencySymbol = '';
  var walletAmount = 0.0.obs;
  final walletAmountTextEditingController = TextEditingController();
  Wallet? oldWallet;

  var isLoading = false.obs;

  void showWalletCurrencyPicker(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    return showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) async {
        currencyTextEditingController.text = currency.name;
        currencyId = currency.code;
        currencySymbol = currency.symbol;
        currencyName.value = currency.name;
        if (oldWallet != null) {
          var amoutExchange = ExchangeRate.exchange(oldWallet!.currencyId, currency.code, oldWallet!.amount.toDouble());
          walletAmount.value = amoutExchange;
          walletAmountTextEditingController.text = amoutExchange.toString();
        }
      },
      favorite: AppValue.favoritedCurrencies,
    );
  }

  void selectIcon(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    final result = await Get.toNamed(Routes.selectIcon);
    if (result != null) {
      walletIconPath.value = result;
    }
  }

  onSave(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    try {
      if (Get.isDialogOpen!) {
        return;
      }
      Utils.showLoadingDialog();
      var newWallet = _createWallet();
      if (newWallet != null) {
        var result;
        if (oldWallet != null) {
          result = await _walletProvider.update(oldWallet!.id!, newWallet);
          DataService.currentUser?.wallets[oldWallet!.id!] = newWallet;
        } else {
          result = await _walletProvider.add(newWallet);
          DataService.currentUser?.wallets[result.id!] = result;
        }
        if ((oldWallet == null && newWallet.amount != 0) || (oldWallet != null && oldWallet!.currencyId == newWallet.currencyId)) {
          await createNewTrans(newWallet.id ?? result.id);
        }
        Utils.hideLoadingDialog();
        switch (Get.currentRoute) {
          case Routes.firstWallet:
            onClosedAddFirstWallet(result);
            break;
          case Routes.editWallet:
            onClosedEditWallet(newWallet);
            break;
          case Routes.addWallet:
            onClosedAddWallet(result);
            break;
          default:
            break;
        }
      } else {
        Utils.hideLoadingDialog();
        Get.snackbar("Error", "Your input data is invalid");
      }
    } on Exception catch (_) {
      Utils.hideLoadingDialog();
      Get.snackbar("Error", "Something go wrong, please wait a minute and try again.");
    }
  }

  Wallet? _createWallet() {
    try {
      var newWallet = Wallet(
        oldWallet?.id,
        name: walletNameTextEditingController.text,
        amount: double.parse(walletAmountTextEditingController.text == "" ? "0" : walletAmountTextEditingController.text),
        currencyId: currencyId,
        iconId: walletIconPath.value,
        currencySymbol: currencySymbol,
      );
      if (newWallet.isValid) {
        return newWallet;
      } else {
        return null;
      }
    } on Exception {
      return null;
    }
  }

  onClosedAddFirstWallet(Wallet wallet) async {
    await WalletProvider().updateCurrentWallet(wallet);
    await updateCurrencyUser(wallet);
    DataService.currentWallet = wallet.obs;
    Get.offAllNamed(Routes.home);
  }

  Future updateCurrencyUser(Wallet wallet) async {
    var user = DataService.currentUser!;
    user.currencyId = wallet.currencyId;
    user.currencySymbol = wallet.currencySymbol;
    await UserProvider().update(user.id!, user);
  }

  Future createNewTrans(String walletId) async {
    final Category category = DataService.categories.where((element) => element.name == "Others".tr).first;
    var transaction = TransactionModel(
      null,
      note: 'Adjut balance'.tr,
      amount: num.parse(walletAmountTextEditingController.text == "" ? "0" : walletAmountTextEditingController.text),
      category: category,
      currencyId: currencyId,
      date: DateTime.now(),
    );
    if (oldWallet != null) {
      transaction.amount = transaction.amount - oldWallet!.amount;
    }
    await TransactionProvider().addToWallet(transaction, walletId);
    await DataService.updateTotalAmount(transaction.amount);
  }

  void onClosedAddWallet(Wallet result) {
    Get.back(result: result);
  }

  void onClosedEditWallet(result) {
    Get.back(result: result);
  }
}
