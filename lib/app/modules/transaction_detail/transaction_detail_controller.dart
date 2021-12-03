import 'package:get/get.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/data/providers/user_provider.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/home/home_controller.dart';
import 'package:keepital/app/routes/pages.dart';
import 'package:tuple/tuple.dart';

class TransactionDetailController extends GetxController
{
  final HomeController _homeController = Get.find<HomeController>();
  late Rx<TransactionModel> trans;

  Future<bool> deleteTransaction() async {
    await TransactionProvider().deleteInWallet(transId(), walletId());
    await updateWallet();
    await updateUser();

    await _homeController.reloadTransList();
    return true;
  }

  Future updateWallet() async {
    wallets[walletId()]!.amount -= amount;
    await WalletProvider().update(walletId(), wallets[walletId()]!);
  }

  Future updateUser() async {
    var user = DataService.currentUser!;
    user.amount -= amount;
    DataService.currentUser = await UserProvider().update(user.id!, user);

    _homeController.total.amount -= amount;
  }

  void onTransUpdated(TransactionModel trans) {
    this.trans.value = trans;
  }

  void navigateToEditTransactionScreen() async {
    var result = await Get.toNamed(Routes.editTransaction, arguments: trans.value);
    if (result != null) {
      Tuple2<num, TransactionModel> val = result; 

      onTransUpdated(val.item2);

      _homeController.total.amount += val.item1;
      await _homeController.reloadTransList();
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