import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/home/home_controller.dart';
import 'package:keepital/app/routes/pages.dart';

class TransactionDetailController extends GetxController {
  final HomeController _homeController = Get.find<HomeController>();
  late Rx<TransactionModel> trans;

  Future deleteTransaction() async {
    Utils.showLoadingDialog();
    await TransactionProvider().deleteInWallet(transId(), walletId());
    await updateWallet();
    await DataService.updateTotalAmount(-amount);

    await _homeController.reloadTransList();
    Utils.hideLoadingDialog();
    Get.back();
  }

  Future updateWallet() async {
    wallets[walletId()]!.amount -= amount;
    await WalletProvider().update(walletId(), wallets[walletId()]!);
  }

  void onTransUpdated(TransactionModel trans) {
    this.trans.value = trans;
  }

  void navigateToEditTransactionScreen() async {
    var result = await Get.toNamed(Routes.editTransaction, arguments: trans.value);
    if (result != null) {
      onTransUpdated(result);

      await _homeController.onEditedTransaction(result);
    }
  }

  String transId() {
    if (trans.value.id == null) throw NullThrownError();
    return trans.value.id!;
  }

  String walletId() {
    if (trans.value.walletId == null) throw NullThrownError();
    return trans.value.walletId!;
  }

  Map<String, Wallet> get wallets => DataService.currentUser!.wallets;
  num get amount => trans.value.category.type == CategoryType.expense ? -trans.value.amount : trans.value.amount;
}
