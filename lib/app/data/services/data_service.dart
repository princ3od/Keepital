import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/models/keepital_user.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/category_provider.dart';
import 'package:keepital/app/data/providers/user_provider.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/auth_service.dart';

class DataService {
  DataService._privateConstructor();
  static final DataService instance = DataService._privateConstructor();

  static KeepitalUser? currentUser;
  static List<Category> categories = [];

  loadCategoryData() async {
    categories = await CategoryProvider().fetchAll();
  }

  loadUserData() async {
    currentUser = await UserProvider().fetch(AuthService.instance.currentUser!.uid);
    currentUser!.wallets = await WalletProvider().fetchAll();
  }

  Future<Wallet?> updateWalletAmount(String id, num diff) async {
    if (currentUser == null || currentUser!.wallets[id] == null) return null;

    var wallet = currentUser!.wallets[id]!;
    wallet.amount += diff;
    currentUser!.wallets[id] = await WalletProvider().update(id, wallet);

    return wallet;
  }

  Future updateTotalAmount(num diff) async {
    if (currentUser == null) return;

    var user = currentUser!;
    user.amount += diff;
    currentUser = await UserProvider().update(user.id!, user);
  }

  static List<Wallet> get wallets => currentUser!.wallets.values.toList();
}
