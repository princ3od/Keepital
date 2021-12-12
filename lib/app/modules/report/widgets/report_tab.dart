import 'package:flutter/material.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/report/widgets/bar_chart_section.dart';
import 'package:keepital/app/modules/report/widgets/overall_section.dart';

class ReportTab extends StatelessWidget {
  const ReportTab({
    Key? key,
    required this.openingAmount,
    required this.closingAmount,
    required this.netIncome,
    required this.startDate,
    required this.endDate,
    required this.transactions,
    required this.timeRange,
  }) : super(key: key);
  final double openingAmount;
  final double closingAmount;
  final double netIncome;
  final DateTime startDate;
  final DateTime endDate;
  final List<TransactionModel> transactions;
  final TimeRange timeRange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        children: [
          OverallSection(openingAmount: openingAmount, closingAmount: closingAmount, netIncome: netIncome),
          BarChartSection(startDate: startDate, endDate: endDate, transactions: transactions, timeRange: timeRange),
        ],
      ),
    );
  }
}
