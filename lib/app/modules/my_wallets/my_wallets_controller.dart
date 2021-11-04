import 'package:get/get.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/routes/pages.dart';

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
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchUserWallets();
  }

  void handingAddNewWallet() {
    Get.toNamed(Routes.addWallet);
  }
}
