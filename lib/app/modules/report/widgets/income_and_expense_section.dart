import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_colors.dart';

class IncomeAndExpenseSection extends StatelessWidget {
  const IncomeAndExpenseSection({Key? key, required this.income, required this.expense}) : super(key: key);
  final double income;
  final double expense;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Income'.tr,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity + 0.2),
                      )),
              const SizedBox(height: 4),
              Text(income.readable, style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 16.5, fontWeight: FontWeight.w600, color: Colors.blue)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Expense'.tr,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity + 0.2),
                      )),
              const SizedBox(height: 4),
              Text(expense.readable, style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 16.5, fontWeight: FontWeight.w600, color: Colors.red)),
            ],
          ),
        ),
        const SizedBox(height: 240),
      ],
    );
  }
}
