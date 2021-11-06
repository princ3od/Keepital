import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:keepital/app/modules/add_wallet/add_wallet_controller.dart';

class AddWalletBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddWalletController>(() => AddWalletController());
  }
}
