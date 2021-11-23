import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/core/values/assets.gen.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/models/keepital_user.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/data/providers/user_provider.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/my_wallets/my_wallets_controller.dart';
import 'package:keepital/app/routes/pages.dart';

class AddWalletController extends GetxController {
  var _walletProvider = WalletProvider();
  var walletNameTextEditingController = TextEditingController(text: 'Cash');
  var currencyTextEditingController = TextEditingController();
  var currencyId = "".obs;
  var walletIconPath = Assets.inAppIconWalletDefault.path.obs;
  var currencySymbol = "".obs;
  final walletAmountTextEditingController = TextEditingController();

  var isLoading = false.obs;

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

  Future<void> showIconCategoryPicker() async {
    var result = await Get.toNamed(Routes.selectIcon);
    if (result != null) {
      walletIconPath.value = result;
    }
  }

  void clearInputData() {
    walletNameTextEditingController.text = "";
    currencyTextEditingController.text = "";
    currencyId.value = "";
    walletIconPath.value = Assets.inAppIconWalletDefault.path;
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
        _addCurrencyIdNSymbol(result);
        DataService.currentUser?.wallets[result.id!] = result;
        await createNewTrans(result.id!);
        Get.snackbar("Warning", "Your's first wallet has been added");
        clearInputData();
        switch (Get.currentRoute) {
          case Routes.firstWallet:
            onClosedAddFirstWallet(result);
            break;
          case Routes.addWallet:
            onCompletedAddWallet();
            break;
          default:
            break;
        }
      } else {
        Get.snackbar("Error", "Your's input data is invalid");
      }
    } on Exception catch (_) {
      Get.snackbar("Error", "Something go wrong, please wait a minute and try again.");
    } finally {
      isLoading.value = false;
    }
  }

  void _addCurrencyIdNSymbol(Wallet w) {
    curUser.currencySymbol = w.currencySymbol;
    curUser.currencyId = w.currencySymbol;
    UserProvider().update(curUser.id!, curUser);
  }

  KeepitalUser get curUser => DataService.currentUser!;

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
    Get.toNamed(Routes.home);
  }

  onClosed() {
    MyWalletsController _walletsController = Get.find<MyWalletsController>();
  }

  onCompletedAddWallet() {}

  Future createNewTrans(String walletId) async {
    var category = Category('v2ORTsRjiq7sslcp5xvf', iconId: '', name: 'Another', type: CategoryType.income, isDebtNLoan: false, parent: '');
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
}
