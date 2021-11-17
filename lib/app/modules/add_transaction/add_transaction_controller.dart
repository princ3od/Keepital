import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/data/providers/user_provider.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/home/home_controller.dart';

class AddTransactionController extends GetxController {
  final HomeController _homeController = Get.find<HomeController>();
  
  var wallets = DataService.currentUser!.wallets;
  var currentWallet = DataService.currentUser!.currentWallet.obs;
  late var curWalletName = (wallets[currentWallet]?.name ?? '').obs;
  late var curWalletAmount = (wallets[currentWallet]?.amount.toString() ?? '').obs;

  RxNum amount = RxNum(0);
  Category? category;
  late var strCategory = ''.tr.obs;
  RxString note = ''.obs;
  var date = DateTime.now();
  late var strDate = date.fullDate.obs;
  var wallet = DataService.currentUser!.wallets[DataService.currentUser!.currentWallet];

  RxBool excludeFromReport = false.obs;

  String oldWalletId = DataService.currentUser!.currentWallet;

  Future createNewTrans(num amount, String note) async {
    amount = category!.type == CategoryType.income ? amount : -amount; 

    var user = DataService.currentUser!;
    user.amount += amount;
    DataService.currentUser = await UserProvider().update(user.id!, user);
    _homeController.total.amount += amount;

    var walletId = currentWallet.value;
    var wallet = wallets[walletId]!;
    wallet.amount += amount;
    DataService.currentUser!.wallets[walletId] = await WalletProvider().update(walletId, wallet);

    var trans = TransactionModel(null, amount: amount.abs(), category: category!, currencyId: wallet.currencyId, date: date, note: note);
    await TransactionProvider().add(trans);
    DataService.currentUser!.currentWallet = oldWalletId;

    _homeController.onCurrentWalletChange(DataService.currentUser!.currentWallet);
    await _homeController.reloadTransList();
  }

  void onSelectCategory(Category? category) {
    strCategory.value = category?.name ?? '';
    this.category = category;
  }
}
