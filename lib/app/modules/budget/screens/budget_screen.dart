import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/data/models/budget.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/global_widgets/wallet_button.dart';
import 'package:keepital/app/modules/budget/widgets/finished_budget_tab.dart';
import 'package:keepital/app/modules/budget/widgets/on_going_budget_tab.dart';
import 'package:keepital/app/routes/pages.dart';

class BudgetScreen extends StatelessWidget {
  BudgetScreen({Key? key}) : super(key: key);

  var list = [Budget('', category: Category('', iconId: '', name: 'Bill', type: CategoryType.expense, parent: '', isDebtNLoan: false), amount: 100, spent: 10, walletId: 'uk9VrxBEqD6w0McdyNcV', isFinished: false, beginDate: DateTime.now(), endDate: DateTime.now().add(Duration(days: 7)), isRepeat: false), Budget('', category: Category('', iconId: '', name: 'Bill', type: CategoryType.expense, parent: '', isDebtNLoan: false), amount: 100, spent: 10, walletId: 'uk9VrxBEqD6w0McdyNcV', isFinished: false, beginDate: DateTime.now(), endDate: DateTime.now().add(Duration(days: 7)), isRepeat: false)];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.textColor,
              ),
              onPressed: () => Get.back(),
            ),
            title: Text("Budgets".tr),
            actions: <Widget>[WalletButton()],
            bottom: TabBar(
              tabs: [
                Text("on_going".tr),
                Text("finished".tr),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Get.toNamed(Routes.addBudget),
          ),
          body: TabBarView(
            children: [
              OnGoingBudgetTab(
                budgets: list,
              ),
              FinishedBudgetTab()
            ],
          )),
    );
  }
}
