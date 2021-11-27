import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/utils/exchange_rate.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/data/providers/user_provider.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/home/home_controller.dart';
import 'package:keepital/app/modules/transaction_detail/transaction_detail_controller.dart';

class AddTransactionController extends GetxController {
  AddTransactionController() {
    walletId = currentWallet.obs;
    walletName = (wallets[walletId]?.name ?? '').obs;
  }

  final HomeController _homeController = Get.find<HomeController>();
  late final TransactionDetailController _transDetailController;

  final amountTextController = TextEditingController();
  final noteTextController = TextEditingController();

  Category? category;
  var strCategory = ''.tr.obs;

  var date = DateTime.now();
  late var strDate = date.fullDate.obs;

  late RxString walletId;
  late RxString walletName;

  Rx<List<String>?> peoples = Rx<List<String>?>([]);

  RxBool excludeFromReport = false.obs;

  Future createNewTrans() async {
    num amount = num.tryParse(amountTextController.text)!;
    String note = noteTextController.text;

    amount = category!.type == CategoryType.income ? amount : -amount;
    num diffInTotal = await ExchangeMoney.exchange(wallets[walletId]!.currencyId, totalCurrencyId, amount.toDouble());

    updateTotalAmount(diffInTotal);
    _homeController.total.amount += diffInTotal;

    updateWalletAmountNTransaction(amount);
    addTransaction(amount, note);

    await _homeController.reloadTransList();
  }

  Future modifyTrans(TransactionModel oldTrans) async {
    num amount = num.tryParse(amountTextController.text)!;
    String note = noteTextController.text;

    amount = category!.type == CategoryType.income ? amount : -amount;
    num diff = amount - oldAmount;
    num diffInTotal = await ExchangeMoney.exchange(wallets[walletId]!.currencyId, totalCurrencyId, diff.toDouble());

    updateTotalAmount(diffInTotal);
    _homeController.total.amount += diffInTotal;

    updateWalletAmountNTransaction(diff);
    updateTransaction(oldTrans, amount, note);

    await _homeController.reloadTransList();
  }

  Future updateTotalAmount(num diff) async {
    var user = DataService.currentUser!;
    user.amount += diff;
    DataService.currentUser = await UserProvider().update(user.id!, user);
  }

  Future updateWalletAmountNTransaction(num diff) async {
    var wallet = wallets[walletId]!;
    wallet.amount += diff;
    DataService.currentUser!.wallets[walletId.value] = await WalletProvider().update(walletId.value, wallet);
  }

  Future updateTransaction(TransactionModel oldTrans, num amount, String note) async {
    var wallet = wallets[walletId]!;

    var modTrans = TransactionModel(oldTrans.id, walletId: oldTrans.walletId, amount: amount.abs(), category: category!, currencyId: wallet.currencyId, date: date, note: note, contact: listToString(peoples.value));
    await TransactionProvider().updateInWallet(modTrans.id!, modTrans.walletId!, modTrans);

    _transDetailController.onTransUpdated(modTrans);
  }

  Future addTransaction(num amount, String note) async {
    var wallet = wallets[walletId]!;
    var trans = TransactionModel(null, amount: amount.abs(), category: category!, currencyId: wallet.currencyId, date: date, note: note, contact: listToString(peoples.value));
    await TransactionProvider().addToWallet(trans, walletId.value);
  }

  void onSelectCategory(Category? category) {
    strCategory.value = category?.name ?? '';
    this.category = category;
  }

  void onLoadData(TransactionModel trans) {
    _transDetailController = Get.find<TransactionDetailController>();

    oldAmount = trans.category.type == CategoryType.income ? trans.amount : -trans.amount;
    amountTextController.text = trans.amount.toString();

    category = trans.category;
    strCategory.value = category?.name ?? '';

    noteTextController.text = trans.note ?? '';

    date = trans.date;
    strDate.value = date.fullDate;

    walletId.value = trans.walletId ?? '';
    walletName.value = wallets[walletId]?.name ?? '';

    peoples.value = stringToList(trans.contact);
  }

  num oldAmount = 0;

  String get totalCurrencyId => DataService.currentUser!.currencyId;
  String get currentWallet => DataService.currentUser!.currentWallet;
  Map<String, Wallet> get wallets => DataService.currentUser!.wallets;
}
