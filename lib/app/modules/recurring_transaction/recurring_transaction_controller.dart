import 'package:get/get.dart';
import 'package:keepital/app/data/models/recurring_transaction.dart';
import 'package:keepital/app/data/providers/recurring_transaction_provider.dart';
import 'package:keepital/app/routes/pages.dart';

class RecurringTransactionController extends GetxController {
  RxBool isLoading = false.obs;
  List<RecurringTransaction> transList = [];
  RxList<RecurringTransaction> onGoings = RxList<RecurringTransaction>();
  RxList<RecurringTransaction> finisheds = RxList<RecurringTransaction>();

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();
    transList = await RecurringTransactionProvider().fetchAll();
    transList.forEach((element) {
      if (element.isMarkedFinished) {
        finisheds.add(element);
      }
      onGoings.add(element);
    });
    isLoading.value = false;
  }

  Future reload() async {
    isLoading.value = true;
    clearAllTrans();

    transList = await RecurringTransactionProvider().fetchAll();
    transList.forEach((element) {
      if (element.isMarkedFinished) {
        finisheds.add(element);
      } else
        onGoings.add(element);
    });
    isLoading.value = false;
  }

  void clearAllTrans() {
    transList.clear();
    onGoings.clear();
    finisheds.clear();
  }

  Future navigateToAddTransaction() async {
    var result = await Get.toNamed(Routes.addRecurringTransaction);
    if (result is RecurringTransaction) {
      isLoading.value = true;
      onGoings.add(result);
      transList.add(result);
      isLoading.value = false;
    }
  }
}
