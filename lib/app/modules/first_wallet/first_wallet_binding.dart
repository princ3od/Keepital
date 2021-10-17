import 'package:get/get.dart';
import 'package:keepital/app/modules/first_wallet/first_wallet_controller.dart';


class FirstWalletScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirstWalletScreenController>(() => FirstWalletScreenController());
  }
}
