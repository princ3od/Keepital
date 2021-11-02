import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/modules/home/home_controller.dart';
import 'package:keepital/app/modules/transactions/widgets/trans_overview.dart';
import 'package:keepital/app/modules/transactions/widgets/transaction_container.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> with TickerProviderStateMixin {
  HomeController _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TransactionProvider().fetchAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Obx(() => TabBarView(
              controller: _controller.tabController.value,
              children: _controller.tabs.map((element) {
                List<TransactionModel> transList = (snapshot.data ?? []) as List<TransactionModel>;
                transList = _controller.filterTransBasedOnTime(transList, element.data!);

                List<DateTime> dateInChoosenTime = [];
                List<String> categoryInChoosenTime = [];

                double totalInCome = 0;
                double totalOutCome = 0;

                List<List<TransactionModel>> transactionListSorted = [];

                transList.sort((a, b) => b.date.compareTo(a.date));

                if (!_controller.viewByDate) {
                  transList.forEach((element) {
                    if (!categoryInChoosenTime.contains(element.category.name)) categoryInChoosenTime.add(element.category.name);
                    if (element.category.type == 'outflow')
                      totalOutCome += element.amount;
                    else
                      totalInCome += element.amount;
                  });

                  categoryInChoosenTime.forEach((cate) {
                    final b = transList.where((element) => element.category.name.compareTo(cate) == 0);
                    transactionListSorted.add(b.toList());
                  });
                } else {
                  transList.forEach((element) {
                    if (!dateInChoosenTime.contains(element.date)) dateInChoosenTime.add(element.date);
                    if (element.category.type == 'outflow')
                      totalOutCome += element.amount;
                    else
                      totalInCome += element.amount;
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

                return Container(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                    itemCount: transactionListSorted.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0)
                        return TransactionsOverview(
                          inflow: totalInCome,
                          outflow: totalOutCome,
                        );
                      return TransactionContainer(transList: transactionListSorted[index - 1]);
                    },
                  ),
                );
              }).toList()));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
