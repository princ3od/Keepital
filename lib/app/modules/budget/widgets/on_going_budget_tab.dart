import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keepital/app/data/models/budget.dart';
import 'package:keepital/app/modules/budget/widgets/budget_item.dart';

class OnGoingBudgetTab extends StatelessWidget {
  OnGoingBudgetTab({Key? key, required this.budgets}) : super(key: key);
  final List<Budget> budgets;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      itemCount: budgets.length,
      itemBuilder: (context, index) {
        return BudgetItem(budget: budgets[index]);
      },
    );
  }
}
