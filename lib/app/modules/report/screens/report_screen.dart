import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/global_widgets/default_loading.dart';
import 'package:keepital/app/modules/home/home_controller.dart';
import 'package:keepital/app/modules/report/report_controller.dart';
import 'package:keepital/app/modules/report/widgets/report_tab.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({Key? key}) : super(key: key);
  final _controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.isLoading.value
        ? DefaultLoading()
        : TabBarView(
            controller: _controller.tabController.value,
            children: _controller.tabs.map((element) {
              RefreshController _refreshController = RefreshController(initialRefresh: false);
              final _range = ReportController.getTimeRangeBaseOnTime(_controller.selectedTimeRange.value, element.data!);
              final transactions = ReportController.transactionsInRange(_controller.transList, _range);
              double openingAmount = ReportController.openingBalance(_controller.transList, _range.start);
              double closingAmount = ReportController.closingBalance(_controller.transList, _range.end);
              double incomeTotal = ReportController.income(transactions);
              double expenseTotal = ReportController.expense(transactions);
              final pieChartData = ReportController.pieChartData(transactions);
              final incomeData = pieChartData[0], expenseData = pieChartData[1];
              double netIncome = incomeTotal - expenseTotal;
              return Container(
                child: SmartRefresher(
                  physics: BouncingScrollPhysics(),
                  controller: _refreshController,
                  onLoading: () async {
                    _refreshController.loadComplete();
                  },
                  onRefresh: () async {
                    _controller.transList.value = await TransactionProvider().fetchAll();
                    _refreshController.refreshCompleted();
                  },
                  child: ReportTab(
                    openingAmount: openingAmount,
                    closingAmount: closingAmount,
                    netIncome: netIncome,
                    transactions: transactions,
                    startDate: _range.start,
                    endDate: _range.end,
                    timeRange: _controller.selectedTimeRange.value,
                    income: incomeTotal,
                    expense: expenseTotal,
                    incomeData: incomeData,
                    expenseData: expenseData,
                  ),
                ),
              );
            }).toList()));
  }
}
