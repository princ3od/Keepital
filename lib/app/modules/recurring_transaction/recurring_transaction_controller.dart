import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/recurring_transaction.dart';
import 'package:keepital/app/data/providers/recurring_transaction_provider.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/routes/pages.dart';

class RecurringTransactionController extends GetxController {
  RxBool isLoading = false.obs;
  var transList = <RecurringTransaction>[];
  var onGoings = <RecurringTransaction>[].obs;
  var finisheds = <RecurringTransaction>[].obs;

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();
    transList = await RecurringTransactionProvider().fetchAll();
    transList.forEach((element) {
      if (element.isMarkedFinished) {
        finisheds.add(element);
      } else
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

      if (result.options.startDate.isToday()) {
        var trans = await TransactionProvider().add(result.toTransactionModel());
        DataService.updateTotalAmount(trans.signedAmount);
        DataService.instance.updateWalletAmount(trans.id!, trans.signedAmount);
      }
      isLoading.value = false;
    }
  }

  Future navigateToEditTransaction(RecurringTransaction trans) async {
    var result = await Get.toNamed(Routes.editRecurringTransaction, arguments: trans);
    if (result is RecurringTransaction) {
      isLoading.value = true;
      if (trans.isMarkedFinished) {
        finisheds.remove(trans);
        finisheds.add(result);
      } else {
        onGoings.remove(trans);
        onGoings.add(result);
      }
      if (result.options.startDate.isToday()) {
        var trans = await TransactionProvider().add(result.toTransactionModel());
        DataService.updateTotalAmount(trans.signedAmount);
        DataService.instance.updateWalletAmount(trans.id!, trans.signedAmount);
      }
      isLoading.value = false;
    }
  }

  Future onDeleteTrans(RecurringTransaction trans) async {
    isLoading.value = true;
    await RecurringTransactionProvider().deleteInWallet(trans.id!, trans.walletId!);
    await Future.delayed(AppValue.delayTime);
    if (trans.isMarkedFinished) {
      finisheds.remove(trans);
    } else
      onGoings.remove(trans);
    isLoading.value = false;
  }

  Future onMarkRecurringTrans(RecurringTransaction trans) async {
    isLoading.value = true;
    trans.isMarkedFinished = !trans.isMarkedFinished;
    await RecurringTransactionProvider().update(trans.id!, trans);
    if (trans.isMarkedFinished) {
      onGoings.remove(trans);
      finisheds.add(trans);
    } else {
      onGoings.add(trans);
      finisheds.remove(trans);
    }
    isLoading.value = false;
  }
}
