import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/data/models/budget.dart';
import 'package:keepital/app/data/providers/budget_provider.dart';
import 'package:keepital/app/modules/budget/budget_controller.dart';

class BudgetDetailController extends GetxController {
  final budgetController = Get.find<BudgetController>();
  Future onDeleteBudget(Budget budget) async {
    Utils.showLoadingDialog();
    await BudgetProvider().deleteInWallet(budget.id!, budget.walletId);
    Utils.hideLoadingDialog();

    updateBudgetsList(budget);
    Get.back();
  }

  void updateBudgetsList(Budget budget) {
    budgetController.isLoading.value = true;
    if (budget.isFinished) {
      budgetController.finishedBudgets.remove(budget);
    } else {
      budgetController.onGoingbudgets.remove(budget);
    }
    budgetController.isLoading.value = false;
  }
}
