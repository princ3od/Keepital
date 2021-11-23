import 'package:get/get.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/routes/pages.dart';

class MyWalletsController extends GetxController {
  var isLoading = true.obs;
  final WalletProvider _walletProvider = WalletProvider();
  List<Wallet> userWalletMap = DataService.wallets;

  void navigatoToAddWalletScreen() {
    Get.toNamed(Routes.addWallet);
  }
}
