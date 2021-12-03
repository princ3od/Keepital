import 'package:get/get.dart';
import 'package:keepital/app/modules/recurring_transaction/recurring_transaction_controller.dart';

class RecurringTransactionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecurringTransactionController>(() => RecurringTransactionController());
  }
}
