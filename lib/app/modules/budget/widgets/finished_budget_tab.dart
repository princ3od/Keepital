import 'package:flutter/widgets.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/data/models/budget.dart';
import 'package:keepital/app/modules/budget/widgets/budget_container.dart';

class FinishedBudgetTab extends StatelessWidget {
  const FinishedBudgetTab({Key? key, required this.budgets}) : super(key: key);
  final List<Budget> budgets;

  @override
  Widget build(BuildContext context) {
    Map<String, List<Budget>> sortedBudgets = {};
    budgets.forEach((element) {
      String key = '${element.beginDate.numbericDate} - ${element.endDate.numbericDate}';
      if (sortedBudgets.containsKey(key)) {
        sortedBudgets[key]!.add(element);
      } else
        sortedBudgets[key] = [element];
    });

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      itemCount: sortedBudgets.length,
      itemBuilder: (context, index) {
        var key = sortedBudgets.keys.elementAt(index);
        return BudgetContainer(budgets: sortedBudgets[key]!);
      },
    );
  }
}
