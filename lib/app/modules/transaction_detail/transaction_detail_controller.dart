import 'package:get/get.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/data/providers/user_provider.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/home/home_controller.dart';

class TransactionDetailController extends GetxController
{
  final HomeController _homeController = Get.find<HomeController>();
  late TransactionModel trans;

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

  String transId() {
    if (trans.id == null) throw NullThrownError();
    return trans.id!;
  }
  String walletId() {
    if (trans.walletId == null) throw NullThrownError();
    return trans.walletId!;
  }
  Map<String, Wallet> get wallets => DataService.currentUser!.wallets;
  num get amount => trans.category.type == CategoryType.expense ? -trans.amount : trans.amount;
}