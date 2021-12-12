import 'package:get/get.dart';
import 'package:keepital/app/modules/budget/budget_controller.dart';

class BudgetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BudgetController>(() => BudgetController());
  }
}
