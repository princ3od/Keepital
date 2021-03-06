import 'package:get/get.dart';
import 'package:keepital/app/data/models/budget.dart';
import 'package:keepital/app/data/providers/budget_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/routes/pages.dart';

class BudgetController extends GetxController {
  RxBool isLoading = false.obs;
  late List<Budget> budgets;
  late var onGoingbudgets = <Budget>[].obs;
  late var finishedBudgets = <Budget>[].obs;

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();
    budgets = await loadBudgets();
    budgets.forEach((element) {
      if (element.isFinished) {
        finishedBudgets.add(element);
      } else {
        onGoingbudgets.add(element);
      }
    });
    isLoading.value = false;
  }

  Future<List<Budget>> loadBudgets() async {
    if (walletId.isEmpty) {
      return await BudgetProvider().fetchAll();
    } else
      return await BudgetProvider().fetchAllInWallet(walletId);
  }

  Future onAddBudget() async {
    var result = await Get.toNamed(Routes.addBudget);
    if (result is Budget) {
      isLoading.value = true;
      onGoingbudgets.add(result);
      isLoading.value = false;
    }
  }

  void onWalletChange(String walletId) async {
    isLoading.value = true;
    finishedBudgets.clear();
    onGoingbudgets.clear();

    budgets = await loadBudgets();
    budgets.forEach((element) {
      if (element.isFinished) {
        finishedBudgets.add(element);
      } else {
        onGoingbudgets.add(element);
      }
    });
    isLoading.value = false;
  }

  String get walletId => DataService.currentUser!.currentWallet;
}
