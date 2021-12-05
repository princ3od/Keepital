import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/models/recurring_transaction.dart';
import 'package:keepital/app/modules/recurring_transaction/recurring_transaction_controller.dart';
import 'package:keepital/app/modules/recurring_transaction/widgets/recurring_transaction_item.dart';

class FinishedRecurringTransactionTab extends StatelessWidget {
  final List<RecurringTransaction> transactions;
  final _controller = Get.find<RecurringTransactionController>();
  FinishedRecurringTransactionTab({Key? key, required this.transactions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: transactions.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return RecurringTransactionItem(transaction: transactions[index],);
        },
      ),
    );
  }
}
