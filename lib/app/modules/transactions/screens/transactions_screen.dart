import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/providers/transaction_provider.dart';
import 'package:keepital/app/modules/home/home_controller.dart';
import 'package:keepital/app/modules/transactions/widgets/trans_overview.dart';
import 'package:keepital/app/modules/transactions/widgets/transaction_container.dart';

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

                  dateInChoosenTime.forEach((date) {
                    final b = transList.where((element) => element.date.compareTo(date) == 0);
                    transactionListSorted.add(b.toList());
                  });
                }

                return Container(
                  child: ListView.builder(
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
