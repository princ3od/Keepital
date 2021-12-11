import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/modules/home/home_controller.dart';
import 'package:keepital/app/modules/report/widgets/balance_section.dart';
import 'package:keepital/app/modules/report/widgets/income_and_expense_section.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({Key? key}) : super(key: key);
  final _controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BalanceSection(
                  openingAmount: DataService.currentWallet.value.amount.toDouble() - _controller.getTotalTransactionAmount(),
                  closingAmount: DataService.currentWallet.value.amount.toDouble(),
                ),
                Divider(thickness: 0.8),
                IncomeAndExpenseSection(
                  netIncome: _controller.getTotalTransactionAmount(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
