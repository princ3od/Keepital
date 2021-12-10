import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/global_widgets/default_loading.dart';
import 'package:keepital/app/global_widgets/wallet_button.dart';
import 'package:keepital/app/modules/budget/budget_controller.dart';
import 'package:keepital/app/modules/budget/widgets/finished_budget_tab.dart';
import 'package:keepital/app/modules/budget/widgets/on_going_budget_tab.dart';

class BudgetScreen extends StatelessWidget {
  BudgetScreen({Key? key}) : super(key: key);
  final controller = Get.find<BudgetController>();

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
            actions: <Widget>[
              WalletButton(
                onWalletChange: controller.onWalletChange,
              )
            ],
            bottom: TabBar(
              tabs: [
                Text("on_going".tr),
                Text("finished".tr),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async => await controller.onAddBudget(),
          ),
          body: Obx(() => controller.isLoading.value
              ? DefaultLoading()
              : TabBarView(
                  children: [
                    OnGoingBudgetTab(
                      budgets: controller.onGoingbudgets,
                    ),
                    FinishedBudgetTab(
                      budgets: controller.finishedBudgets,
                    )
                  ],
                ))),
    );
  }
}
