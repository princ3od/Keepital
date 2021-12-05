import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/models/recurring_transaction.dart';
import 'package:keepital/app/data/models/repeat_options.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/global_widgets/default_loading.dart';
import 'package:keepital/app/global_widgets/wallet_button.dart';
import 'package:keepital/app/modules/recurring_transaction/recurring_transaction_controller.dart';
import 'package:keepital/app/modules/recurring_transaction/widgets/finished_recurring_transaction_tab.dart';
import 'package:keepital/app/modules/recurring_transaction/widgets/on_going_recurring_trans_tab.dart';
import 'package:keepital/app/routes/pages.dart';

class RecurringTransactionScreen extends StatelessWidget {
  RecurringTransactionScreen({Key? key}) : super(key: key);
  final _controller = Get.find<RecurringTransactionController>();
  RepeatOptions options = RepeatOptions(id: 0, startDate: DateTime.now(), cycleLength: 7, recurUnitId: 0);
  Category category = Category('', iconId: '', type: CategoryType.income, name: 'Bill', parent: '', isDebtNLoan: false);
  List<RecurringTransaction> trans = [RecurringTransaction('', amount: 10, options: RepeatOptions(id: 0, startDate: DateTime.now(), cycleLength: 7, recurUnitId: 0), isMarkedFinished: false, currencyId: 'USD', category: Category('', iconId: '', type: CategoryType.income, name: 'Bill', parent: '', isDebtNLoan: false))];

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
            onPressed: () {
              Get.toNamed(Routes.addRecurringTransaction);
            },
          ),
          body: TabBarView(
            children: [
              _controller.isLoading
                  ? DefaultLoading()
                  : OnGoingTransactionTab(
                      transactions: trans,
                    ),
              _controller.isLoading
                  ? DefaultLoading()
                  : FinishedRecurringTransactionTab(
                      transactions: trans,
                    ),
            ],
          )),
    );
  }
}
