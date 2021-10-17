import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/models/Transaction.dart';
import 'package:keepital/app/modules/transactions/widgets/trans_overview.dart';
import 'package:keepital/app/modules/transactions/widgets/transaction_container.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>
    with TickerProviderStateMixin {
  List<Transaction> _transactions = [
    Transaction(
        category: 'Electricity Bill',
        type: TransactionType.Outflow,
        amount: 400000,
        note: 'bill for oct 2020, why the heck it is so high???'),
    Transaction(
        category: 'Others',
        type: TransactionType.Inflow,
        amount: 200000,
        note: 'amazing!')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0)
                  return TransactionsOverview();
                else
                  return TransactionContainer(
                    transaction: _transactions,
                  );
              })),
    );
  }
}
