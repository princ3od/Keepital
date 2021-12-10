import 'package:flutter/widgets.dart';
import 'package:keepital/app/data/models/budget.dart';
import 'package:keepital/app/modules/budget/widgets/budget_item.dart';

class FinishedBudgetTab extends StatelessWidget {
  const FinishedBudgetTab({Key? key, required this.budgets}) : super(key: key);
  final List<Budget> budgets;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: budgets.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) => BudgetItem(budget: budgets[index]),
    );
  }
}
