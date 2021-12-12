import 'package:get/get.dart';
import 'package:keepital/app/modules/transaction_detail/transaction_detail_controller.dart';

class TransactionDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionDetailController>(() => TransactionDetailController());
  }
}
