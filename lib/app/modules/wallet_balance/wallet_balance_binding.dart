import 'package:get/get.dart';
import 'package:keepital/app/modules/wallet_balance/wallet_balance_controller.dart';

class WalletBalanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletBalanceController>(() => WalletBalanceController());
  }
}
