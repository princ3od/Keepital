import 'package:get/get.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/routes/pages.dart';

class MyWalletsController extends GetxController {
  var isLoading = true.obs;
  final WalletProvider _walletProvider = WalletProvider();
  var wallets = DataService.wallets.obs;

  Future<void> navigatoToAddWalletScreen() async {
    var result = await Get.toNamed(Routes.addWallet);
    if (result != null) {
      wallets.add(result);
    }
  }
}
