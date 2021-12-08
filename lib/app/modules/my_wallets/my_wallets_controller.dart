import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/data/models/wallet.dart';
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

  Future<void> deleteWallet(Wallet value) async {
    Utils.showLoadingDialog();
    wallets.remove(value);
    await _walletProvider.delete(value.id!);
    DataService.currentUser!.wallets.remove(value.id);
    Utils.hideLoadingDialog();
    if (!DataService.currentUser!.hasAnyWallet) {
      Get.offAllNamed(Routes.firstWallet);
    }
  }

  Future<void> editWallet(int index) async {
    var result = await Get.toNamed(Routes.editWallet, arguments: wallets.value[index]);
    if (result != null) {
      wallets.value[index] = result;
      wallets.refresh();
    }
  }
}
