import 'package:get/get.dart';
import 'package:keepital/app/modules/add_wallet/add_wallet_controller.dart';

class FirstWalletScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddWalletController>(() => AddWalletController());
  }
}
