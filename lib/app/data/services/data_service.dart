import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/models/keepital_user.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/budget_provider.dart';
import 'package:keepital/app/data/providers/category_provider.dart';
import 'package:keepital/app/data/providers/event_provider.dart';
import 'package:keepital/app/data/providers/exchange_rate_provider.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/data/providers/user_provider.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/auth_service.dart';

class DataService {
  DataService._privateConstructor();
  static final DataService instance = DataService._privateConstructor();
  static late Wallet total;

  static KeepitalUser? currentUser;
  static List<Category> categories = [];

  static late Rx<Wallet> currentWallet;

  loadCategoryData() async {
    categories = await CategoryProvider().fetchAll();
  }

  loadUserData() async {
    currentUser = await UserProvider().fetch(AuthService.instance.currentUser!.uid);
    currentUser!.wallets = await WalletProvider().fetchAll();

    createTotalWallet();
    currentWallet = (currentUser!.wallets[currentUser!.currentWallet] ?? total).obs;
  }

  static void createTotalWallet() {
    total = Wallet('', name: 'Total'.tr, amount: currentUser!.amount, currencyId: currentUser!.currencyId, iconId: '', currencySymbol: currentUser!.currencySymbol);
  }

  static Future<Wallet?> updateWalletAmount(String id, num diff) async {
    if (currentUser == null || currentUser!.wallets[id] == null) return null;

    var wallet = currentUser!.wallets[id]!;
    wallet.amount += diff;
    currentUser!.wallets[id] = await WalletProvider().update(id, wallet);

    return wallet;
  }

  static Future updateTotalAmount(num diff) async {
    if (currentUser == null) return;

    var user = currentUser!;
    user.amount += diff;
    currentUser = await UserProvider().update(user.id!, user);
    total.amount += diff;
    currentWallet.update((val) {});
  }

  Future reCalculateTotal() async {
    if (currentUser == null) return;

    var user = currentUser!;
    user.amount = 0;
    for (var wallet in user.wallets.values) {
      user.amount += wallet.amount * ExchangeRate.getRate(wallet.currencyId, user.currencyId);
    }
    currentUser = await UserProvider().update(user.id!, user);
    total.amount = user.amount;
    currentWallet.update((val) {});
  }

  static void onCurrentWalletChange(String id) {
    currentUser!.currentWallet = id;
    currentWallet.value = currentUser!.wallets[id] ?? DataService.total;
    UserProvider().updateCurrentWallet(currentUser!.id!, id);
  }

  static Future<TransactionModel> addTransaction(TransactionModel transaction) async {
    num diffInTotal = ExchangeRate.exchange(transaction.currencyId, currentUser!.currencyId, transaction.signedAmount.toDouble());
    transaction = await TransactionProvider().addToWallet(transaction, transaction.walletId!);
    await updateTotalAmount(diffInTotal);
    await updateWalletAmount(transaction.walletId!, transaction.signedAmount);

    if (transaction.category.isExpense) {
      await BudgetProvider().updateBudgetSpent(transaction.walletId!, transaction.category.id!, transaction.date, transaction.amount);
    }

    if (transaction.haveEvent) {
      await EventProvider().updateSpent(transaction.eventId!, -transaction.signedAmount, transaction.currencyId);
    }

    return transaction;
  }

  static Future modifyTransaction(TransactionModel modTransaction, num diff) async {
    num diffInTotal = ExchangeRate.exchange(modTransaction.currencyId, currentUser!.currencyId, diff.toDouble());
    await TransactionProvider().updateInWallet(modTransaction.id!, modTransaction.walletId!, modTransaction);
    updateTotalAmount(diffInTotal);
    updateWalletAmount(modTransaction.walletId!, diff);

    if (modTransaction.category.isExpense) {
      await BudgetProvider().updateBudgetSpent(modTransaction.walletId!, modTransaction.category.id!, modTransaction.date, -diff);
    }

    if (modTransaction.haveEvent) {
      await EventProvider().updateSpent(modTransaction.eventId!, -diff, modTransaction.currencyId);
    }
  }

  static List<Wallet> get wallets => currentUser!.wallets.values.toList();
}
