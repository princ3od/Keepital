import 'package:get/get.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';

class MyWalletsController extends GetxController {
  var isLoading = true.obs;
  final WalletProvider _walletProvider = WalletProvider();
  List<Wallet> userWalletMap = [];

  Future<void> fetchUserWallets() async {
    isLoading.value = true;
    userWalletMap.clear();
    var mapWallet = await _walletProvider.fetchAll();
    mapWallet.forEach((key, value) {
      userWalletMap.add(value);
    });
    isLoading.value = false;
    print("load xong");
  }
}
