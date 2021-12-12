import 'package:get/get.dart';
import 'package:keepital/app/modules/add_transaction/add_transaction_controller.dart';

class AddTransactionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTransactionController>(() => AddTransactionController());
  }
}
