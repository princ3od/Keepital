import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/global_widgets/default_loading.dart';
import 'package:keepital/app/modules/home/home_controller.dart';
import 'package:keepital/app/modules/transactions/widgets/trans_overview.dart';
import 'package:keepital/app/modules/transactions/widgets/transaction_by_category_container.dart';
import 'package:keepital/app/modules/transactions/widgets/transaction_by_date_container.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> with TickerProviderStateMixin {
  final HomeController _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return buildCtn();
  }

  Widget buildCtn() {
    return Obx(() => _controller.isLoading.value
        ? DefaultLoading()
        : TabBarView(
            controller: _controller.tabController.value,
            children: _controller.tabs.map((element) {
              RefreshController _refreshController = RefreshController(initialRefresh: false);

              var x = _controller.getTabData(element);
              List<List<TransactionModel>> transactionListSorted = x.item1;
              double totalInflow = x.item2;
              double totalOutflow = x.item3;

              return Container(
                child: SmartRefresher(
                  controller: _refreshController,
                  onLoading: () async {
                    _refreshController.loadComplete();
                  },
                  onRefresh: () async {
                    _controller.transList.value = await TransactionProvider().fetchAll();
                    _refreshController.refreshCompleted();
                  },
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                    itemCount: transactionListSorted.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0)
                        return TransactionsOverview(
                          inflow: totalInflow,
                          outflow: totalOutflow,
                          onViewReport: () => _controller.pageController.jumpToPage(AppValue.reportTabIndex),
                        );
                      return _controller.viewByDate.value
                          ? TransactionByDateContainer(transList: transactionListSorted[index - 1])
                          : TransactionByCategoryContainer(
                              transList: transactionListSorted[index - 1],
                            );
                    },
                  ),
                ),
              );
            }).toList()));
  }
}
