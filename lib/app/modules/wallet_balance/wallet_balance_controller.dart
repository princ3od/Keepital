import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';

class WalletBalanceController extends GetxController {
  WalletBalanceController() {
    walletId = currentWallet.obs;
    walletName = (wallets[walletId]?.name ?? '').obs;
    currencyId = wallets[walletId]?.currencyId ?? 'None';
  }

  void initBalance() {
    currentBalanceController.text = wallets[walletId]?.amount.toString() ?? '';
    oldBalance = wallets[walletId]?.amount ?? 0;
  }

  late RxString walletId;
  late RxString walletName;
  late String currencyId;

  TextEditingController currentBalanceController = TextEditingController();
  var isExcludedReport = false.obs;
  Wallet? selectedWallet;

  num oldBalance = 0;

  Future onSavePressed() async {
    num balance = num.parse(currentBalanceController.text);
    num diff = balance - oldBalance;
    if (isValidData()) {
      if (diff > 0) {
        var trans = TransactionModel('', amount: diff, note: 'Adjust balance'.tr, category: income, walletId: walletId.value, currencyId: currencyId, date: DateTime.now(), excludeFromReport: isExcludedReport.value);
        trans = await DataService.addTransaction(trans);
        Get.back(result: trans);
      } else if (diff < 0) {
        var trans = TransactionModel('', amount: diff.abs(), note: 'Adjust balance'.tr, category: expense, walletId: walletId.value, currencyId: currencyId, date: DateTime.now(), excludeFromReport: isExcludedReport.value);
        trans = await DataService.addTransaction(trans);
        Get.back(result: trans);
      }
    }
  }

  void onExcludeSettingChanged(bool value) {
    isExcludedReport.value = value;
  }

  bool isValidData() {
    if (walletId.isEmpty) {
      Get.snackbar('', '', titleText: Text('Info'.tr), messageText: Text('Please fill out the wallet field'.tr));
      return false;
    } else if (currentBalanceController.text.isEmpty) {
      Get.snackbar('', '', titleText: Text('Info'.tr), messageText: Text('Please fill out the balance field'.tr));
      return false;
    }
    return true;
  }

  Category get income => Category('bCELAshx0vl1vhD52IQk', iconId: '', name: 'Others', type: CategoryType.income, parent: '', isDebtNLoan: false);
  Category get expense => Category('LRJhaM4TzOx6WmTwczOh', iconId: '', name: 'Others', type: CategoryType.expense, parent: '', isDebtNLoan: false);

  String get currentWallet => DataService.currentUser!.currentWallet;
  Map<String, Wallet> get wallets => DataService.currentUser!.wallets;
}
