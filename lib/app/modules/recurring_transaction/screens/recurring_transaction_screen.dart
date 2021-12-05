import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/global_widgets/default_loading.dart';
import 'package:keepital/app/global_widgets/wallet_button.dart';
import 'package:keepital/app/modules/recurring_transaction/recurring_transaction_controller.dart';
import 'package:keepital/app/modules/recurring_transaction/widgets/finished_recurring_transaction_tab.dart';
import 'package:keepital/app/modules/recurring_transaction/widgets/on_going_recurring_trans_tab.dart';

class RecurringTransactionScreen extends StatelessWidget {
  RecurringTransactionScreen({Key? key}) : super(key: key);
  final _controller = Get.find<RecurringTransactionController>();

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
              onPressed: () => Navigator.pop(context),
            ),
            title: Text("Recurring Transactions".tr),
            actions: <Widget>[
              WalletButton(
                onWalletChange: (id) {
                  _controller.reload();
                },
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
            onPressed: _controller.navigateToAddTransaction,
          ),
          body: Obx(() => TabBarView(
                children: [
                  _controller.isLoading.value
                      ? DefaultLoading()
                      : OnGoingTransactionTab(
                          transactions: _controller.onGoings,
                        ),
                  _controller.isLoading.value
                      ? DefaultLoading()
                      : FinishedRecurringTransactionTab(
                          transactions: _controller.finisheds,
                        ),
                ],
              ))),
    );
  }
}
