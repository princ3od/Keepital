import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/core/values/assets.gen.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/modules/my_wallets/my_wallets_controller.dart';
import 'package:keepital/app/routes/pages.dart';

class AddWalletController extends GetxController {
  var _walletProvider = WalletProvider();
  var walletNameTextEditingController = TextEditingController(text: 'Cash');
  var currencyTextEditingController = TextEditingController();
  var currencyName = ''.obs;
  var currencyId = "".obs;
  var walletIconPath = Assets.inAppIconWalletDefault.path.obs;
  var currencySymbol = "".obs;
  var walletAmount = 0.0.obs;
  final walletAmountTextEditingController = TextEditingController();

  var isLoading = false.obs;

  void showWalletCurrencyPicker(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    return showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        currencyTextEditingController.text = currency.name;
        currencyId.value = currency.code;
        currencySymbol.value = currency.symbol;
        currencyName.value = currency.name;
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
        var result = await _walletProvider.add(newWallet);
        DataService.currentUser?.wallets[result.id!] = result;
        if (newWallet.amount != 0) {
          await createNewTrans(result.id!);
        }
        switch (Get.currentRoute) {
          case Routes.firstWallet:
            onClosedAddFirstWallet(result);
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
    } finally {
      Utils.hideLoadingDialog();
    }
  }

  Wallet? _createWallet() {
    try {
      var newWallet = Wallet(null,
          name: walletNameTextEditingController.text,
          amount: double.parse(walletAmountTextEditingController.text == "" ? "0" : walletAmountTextEditingController.text),
          currencyId: currencyId.value,
          iconId: walletIconPath.value,
          currencySymbol: currencySymbol.value);
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
    Get.offAllNamed(Routes.home);
  }

  Future createNewTrans(String walletId) async {
    final Category category = DataService.categories.where((element) => element.name == "Others").first;
    var trans = TransactionModel(
      null,
      note: '',
      amount: num.parse(walletAmountTextEditingController.text == "" ? "0" : walletAmountTextEditingController.text),
      category: category,
      currencyId: currencyId.value,
      date: DateTime.now(),
    );
    await TransactionProvider().addToWallet(trans, walletId);
  }

  void onClosedAddWallet(Wallet result) {
    Get.back(result: result);
    MyWalletsController myWalletsController = Get.find<MyWalletsController>();
    myWalletsController.wallets.add(result);
  }
}
