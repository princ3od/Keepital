import 'package:flutter/material.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/report/report_controller.dart';
import 'package:keepital/app/modules/report/widgets/bar_chart_section.dart';
import 'package:keepital/app/modules/report/widgets/overall_section.dart';
import 'package:keepital/app/modules/report/widgets/pie_chart_section.dart';

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
    required this.income,
    required this.expense,
    required this.incomeData,
    required this.expenseData,
  }) : super(key: key);
  final double openingAmount;
  final double closingAmount;
  final double netIncome;
  final double income;
  final double expense;
  final DateTime startDate;
  final DateTime endDate;
  final List<TransactionModel> transactions;
  final TimeRange timeRange;
  final Map<String, CategoryPercent> incomeData;
  final Map<String, CategoryPercent> expenseData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            OverallSection(openingAmount: openingAmount, closingAmount: closingAmount, netIncome: netIncome),
            BarChartSection(startDate: startDate, endDate: endDate, transactions: transactions, timeRange: timeRange),
            const SizedBox(height: 32),
            PieChartSection(incomeData: incomeData, expenseData: expenseData, income: income, expense: expense),
          ],
        ),
      ),
    );
  }
}
