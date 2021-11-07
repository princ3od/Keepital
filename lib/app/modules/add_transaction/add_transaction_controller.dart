import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/data/providers/user_provider.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';

var formatter = new DateFormat('dd MMMM yyyy');

class AddTransactionController extends GetxController {
  var wallets = DataService.currentUser!.wallets;
  var currentWallet = DataService.currentUser!.currentWallet.obs;
  late var curWalletName = (wallets[currentWallet]?.name ?? '').obs;
  late var curWalletAmount = (wallets[currentWallet]?.amount.toString() ?? '').obs;

  var categories = DataService.categories;
  RxInt selectedIndex = (-1).obs;

  RxNum amount = RxNum(0);
  Category? category;
  late var strCategory = ''.tr.obs;
  RxString note = ''.obs;
  var date = DateTime.now();
  late var strDate = formatter.format(date).obs;
  var wallet = DataService.currentUser!.wallets[DataService.currentUser!.currentWallet];

  RxBool excludeFromReport = false.obs;

  String oldWalletId = '';

  Future createNewTrans(num amount) async {
    var user = DataService.currentUser!;
    user.amount = category!.type == CategoryType.income ? user.amount + amount : user.amount - amount;
    DataService.currentUser = await UserProvider().update(user.id!, user);

    var walletId = currentWallet.value;
    var wallet = wallets[walletId]!;
    wallet.amount = category!.type == CategoryType.income ? wallet.amount + amount : wallet.amount - amount;
    DataService.currentUser!.wallets[walletId] = await WalletProvider().update(walletId, wallet);

    var trans = TransactionModel(null, amount: amount, category: category!, currencyId: 'USD', date: date);
    await TransactionProvider().add(trans);
    DataService.currentUser!.currentWallet = oldWalletId;
  }
}
