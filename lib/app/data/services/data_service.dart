import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/models/keepital_user.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/category_provider.dart';
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

    total = Wallet('', name: 'Total'.tr, amount: currentUser!.amount, currencyId: currentUser!.currencyId, iconId: '', currencySymbol: currentUser!.currencySymbol);
    currentWallet = (currentUser!.wallets[currentUser!.currentWallet] ?? total).obs;
  }

  Future<Wallet?> updateWalletAmount(String id, num diff) async {
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

  static void onCurrentWalletChange(String id) {
    currentUser!.currentWallet = id;
    currentWallet.value = currentUser!.wallets[id] ?? DataService.total;
  }

  static List<Wallet> get wallets => currentUser!.wallets.values.toList();
}
