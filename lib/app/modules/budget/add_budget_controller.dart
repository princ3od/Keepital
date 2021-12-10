import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/assets.gen.dart';
import 'package:keepital/app/data/models/budget.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/budget_provider.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/routes/pages.dart';
import 'package:tuple/tuple.dart';

class AddBudgetController extends GetxController {
  AddBudgetController() {
    walletId = currentWallet.obs;
    walletName = (wallets[walletId]?.name ?? '').obs;
  }

  Category? category;
  var strCategory = 'All category'.tr.obs;
  RxString categoryIconId = Assets.iconsUnknown.path.obs;

  final amountTextController = TextEditingController();

  var startDate = DateTime.now().firstDateOfMonth();
  var endDate = DateTime.now().lastDateOfMonth();
  late var strDate = 'This month'.tr.obs;

  late RxString walletId;
  late RxString walletName;

  RxBool repeat = false.obs;

  void onSelectCategory(Category? category) {
    strCategory.value = category?.name ?? 'All category'.tr;
    categoryIconId.value = category?.iconId ?? Assets.iconsUnknown.path;
    if (categoryIconId.value.isEmpty) categoryIconId.value = Assets.inAppIconElectricityBill.path;
    this.category = category;
  }

  Future onTimeRangeTap(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    var result = await Get.toNamed(Routes.selectTimeRange);
    if (result != null) {
      Tuple2<DateTime?, DateTime?> range = result;

      startDate = range.item1!;
      endDate = range.item2!;
      strDate.value = getStringRange(startDate, endDate);
    }
  }

  void onSaveTap(Budget? old) async {
    switch (Get.currentRoute) {
      case Routes.editBudget:
        await onModifyBudget(old!);
        break;
      default:
        await onAddBudget();
    }
  }

  Future onAddBudget() async {
    Utils.showLoadingDialog();
    num spent = await getSpent();
    var budget = Budget('', category: category, amount: num.parse(amountTextController.text), spent: spent, currencyId: wallets[walletId]!.currencyId, walletId: walletId.value, isFinished: false, beginDate: startDate, endDate: endDate, isRepeat: repeat.value);
    budget = await BudgetProvider().add(budget);
    Utils.hideLoadingDialog();
    Get.back(result: budget);
  }

  Future onModifyBudget(Budget old) async {
    Utils.showLoadingDialog();
    num spent = await getSpent();
    var budget = Budget(old.id, category: category, amount: num.parse(amountTextController.text), spent: spent, currencyId: wallets[walletId]!.currencyId, walletId: walletId.value, isFinished: false, beginDate: startDate, endDate: endDate, isRepeat: repeat.value);
    budget = await BudgetProvider().update(budget.id!, budget);
    Utils.hideLoadingDialog();
    Get.back(result: budget);
  }

  Future<num> getSpent() async {
    num spent = 0;

    var trans = await TransactionProvider().fetchAllInWalletOfRange(walletId.value, startDate, endDate);
    trans.forEach((element) {
      if ((category == null || element.category.id == category!.id) && element.category.type == CategoryType.expense) {
        spent += element.amount;
      }
    });
    return spent;
  }

  String getStringRange(DateTime start, DateTime end) {
    var now = DateTime.now();
    if (start.isSameDate(now.firstDateOfWeek()) && end.isSameDate(now.lastDateOfWeek())) {
      return 'This week'.tr;
    } else if (start.isSameDate(now.firstDateOfNextWeek()) && end.isSameDate(now.lastDateOfNextWeek())) {
      return 'Next week'.tr;
    } else if (start == now.firstDateOfMonth() && end == now.lastDateOfMonth()) {
      return 'This month'.tr;
    } else if (start == now.firstDateOfNextMonth() && end == now.lastDateOfNextMonth()) {
      return 'Next month'.tr;
    } else if (start == now.firstDateOfQuarter() && end == now.lastDateOfQuarter()) {
      return 'This quarter'.tr;
    } else if (start == now.firstDateOfNextQuarter() && end == now.lastDateOfNextQuarter()) {
      return 'Next quarter'.tr;
    } else if (start == now.firstDateOfYear() && end == now.lastDateOfYear()) {
      return 'This year'.tr;
    } else if (start == now.firstDateOfNextYear() && end == now.lastDateOfNextYear()) {
      return 'Next year'.tr;
    }
    return '${start.numbericDate} - ${end.numbericDate}';
  }

  void loadData(Budget budget) {
    category = budget.category;
    strCategory.value = budget.category?.name ?? 'All category'.tr;
    categoryIconId.value = budget.category?.iconId ?? Assets.iconsUnknown.path;

    amountTextController.text = budget.amount.toString();

    startDate = budget.beginDate;
    endDate = budget.endDate;
    strDate.value = getStringRange(startDate, endDate);

    walletId.value = budget.walletId;
    walletName.value = wallets[walletId.value]?.name ?? '';

    repeat.value = budget.isRepeat;
  }

  String get currentWallet => DataService.currentUser!.currentWallet;
  Map<String, Wallet> get wallets => DataService.currentUser!.wallets;
}
