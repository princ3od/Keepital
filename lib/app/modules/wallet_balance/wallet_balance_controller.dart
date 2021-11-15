import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/routes/pages.dart';
import 'widgets/wallets_modal_bottom_sheet.dart';

class WalletBalanceController extends GetxController {
  List<Wallet> wallets = [];
  TextEditingController selectedWalletController = TextEditingController();
  TextEditingController currentBalanceController = TextEditingController();
  num changedAmount = 0.0;
  var iconImgData = "".obs;
  var isExcludedReport = false.obs;
  Wallet? selectedWallet;
  @override
  void onInit() {
    super.onInit();
    wallets = DataService.currentUser!.wallets.values.toList();
  }

  void showModalBottomShee() {
    Get.bottomSheet(
      WalletsModalsBottomSheet(
        onSelect: (Wallet selectedWallet) async {
          onCloseModalBottomSheet(selectedWallet);
        },
        wallets: wallets,
      ),
    );
  }

  void onCloseModalBottomSheet(Wallet selectedWallet) {
    Get.back();
    selectedWalletController.text = selectedWallet.name;
    currentBalanceController.text = selectedWallet.amount.toString();
    iconImgData.value = selectedWallet.iconId;
    this.selectedWallet = selectedWallet;
  }

  Future<void> onSavePressed() async {
    if (this.selectedWallet != null) {
      changedAmount = double.parse(selectedWallet!.amount.toString()) - double.parse(currentBalanceController.text);
      this.selectedWallet?.name = selectedWalletController.text;
      this.selectedWallet?.amount = num.parse(currentBalanceController.text);
      await WalletProvider().update(this.selectedWallet!.id!, this.selectedWallet!);
      DataService.currentUser!.wallets[selectedWallet?.id ?? ""] = this.selectedWallet!;
      await onUpdateComplete(selectedWallet!);
    }
  }

  Future<void> onUpdateComplete(Wallet wallet) async {
    await createNewTrans(wallet);
    Get.snackbar("Warning", "Update successfully!");
    clearCache();
  }

  void clearCache() {
    selectedWalletController.text = "";
    currentBalanceController.text = "";
    iconImgData.value = "";
    changedAmount = 0.0;
  }

  void onExcludeSettingChanged(bool value) {
    isExcludedReport.value = value;
  }

  Future createNewTrans(Wallet wallet) async {
    await Get.toNamed(Routes.categories);
    var category = Category('v2ORTsRjiq7sslcp5xvf', iconId: '', name: 'Another', type: (changedAmount < 0) ? CategoryType.income : CategoryType.expense, isDebtNLoan: false, parent: '');
    var trans = TransactionModel(
      null,
      amount: (changedAmount < 0) ? -changedAmount : changedAmount,
      category: category,
      currencyId: wallet.currencyId,
      date: DateTime.now(),
    );
    trans.excludeFromReport = isExcludedReport.value;
    await TransactionProvider().addToWallet(trans, wallet.id!);
  }
}
