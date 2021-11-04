import 'package:get/get.dart';
import 'package:keepital/app/modules/my_wallets/my_wallets_controller.dart';

class MyWalletsBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<MyWalletsController>(() => MyWalletsController());
  }
}
