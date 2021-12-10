import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/data/models/budget.dart';
import 'package:keepital/app/data/providers/budget_provider.dart';
import 'package:keepital/app/modules/budget/budget_controller.dart';
import 'package:keepital/app/routes/pages.dart';

class BudgetDetailController extends GetxController {
  final budgetController = Get.find<BudgetController>();
  late Rx<Budget> budget;
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

  Future onEditBudget(Budget b) async {
    var result = await Get.toNamed(Routes.editBudget, arguments: b);
    if (result is Budget) {
      budget.value = result;
      budgetController.isLoading.value = true;
      if (b.isFinished) {
        budgetController.finishedBudgets.remove(b);
        budgetController.finishedBudgets.add(result);
      } else {
        budgetController.onGoingbudgets.remove(b);
        budgetController.onGoingbudgets.add(result);
      }
      budgetController.isLoading.value = false;
    }
  }
}
