import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/home/home_controller.dart';
import 'package:keepital/app/modules/transactions/widgets/trans_overview.dart';
import 'package:keepital/app/modules/transactions/widgets/transaction_by_category_container.dart';
import 'package:keepital/app/modules/transactions/widgets/transaction_by_date_container.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tuple/tuple.dart';

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
        ? Center(child: CircularProgressIndicator())
        : TabBarView(
            controller: _controller.tabController.value,
            children: _controller.tabs.map((element) {
              RefreshController _refreshController = RefreshController(initialRefresh: false);

              var x = getTabData(_controller.transList.toList(), element);
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
                      height: 10,
                    ),
                    itemCount: transactionListSorted.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0)
                        return TransactionsOverview(
                          inflow: totalInflow,
                          outflow: totalOutflow,
                        );
                      return _controller.viewByDate.value
                          ? TransactionByDateContainer(transList: transactionListSorted[index - 1], exchangeRates: _controller.exchangeRates)
                          : TransactionByCategoryContainer(
                              transList: transactionListSorted[index - 1],
                              exchangeRates: _controller.exchangeRates,
                            );
                    },
                  ),
                ),
              );
            }).toList()));
  }

  Tuple3 getTabData(List<TransactionModel> transList, Text element) {
    transList = _controller.filterTransBasedOnTime(transList, element.data!);

    List<DateTime> dateInChoosenTime = [];
    List<String> categoryInChoosenTime = [];

    double totalInCome = 0;
    double totalOutCome = 0;

    List<List<TransactionModel>> transactionListSorted = [];

    transList.sort((a, b) => b.date.compareTo(a.date));

    if (!_controller.viewByDate.value) {
      transList.forEach((element) {
        if (!categoryInChoosenTime.contains(element.category.name)) categoryInChoosenTime.add(element.category.name);

        double rate = 1;
        if (_controller.isTotalWallet) {
          var fromCur = element.currencyId;
          var toCur = _controller.total.currencyId;
          rate = _controller.exchangeRates[Tuple2(fromCur, toCur)] ?? 1;
        }

        if (element.category.type == CategoryType.expense)
          totalOutCome += element.amount * rate;
        else
          totalInCome += element.amount * rate;
      });

      categoryInChoosenTime.forEach((cate) {
        final b = transList.where((element) => element.category.name.compareTo(cate) == 0);
        transactionListSorted.add(b.toList());
      });
    } else {
      transList.forEach((element) {
        if (!dateInChoosenTime.contains(element.date)) dateInChoosenTime.add(element.date);

        double rate = 1;
        if (_controller.isTotalWallet) {
          var fromCur = element.currencyId;
          var toCur = _controller.total.currencyId;
          rate = _controller.exchangeRates[Tuple2(fromCur, toCur)] ?? 1;
        }

        if (element.category.type == CategoryType.expense)
          totalOutCome += element.amount * rate;
        else
          totalInCome += element.amount * rate;
      });

      Map<String, bool> selectedDates = {};

      dateInChoosenTime.forEach((date) {
        String strDate = DateFormat('dd MMM yyy').format(date);
        if (selectedDates[strDate] ?? true) {
          final b = transList.where((element) => element.date.isSameDate(date));
          transactionListSorted.add(b.toList());
          selectedDates[strDate] = false;
        }
      });
    }

    return Tuple3<List<List<TransactionModel>>, double, double>(transactionListSorted, totalInCome, totalOutCome);
  }
}
