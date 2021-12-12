import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/data/models/budget.dart';
import 'package:keepital/app/modules/budget/widgets/budget_item.dart';

class BudgetContainer extends StatelessWidget {
  const BudgetContainer({Key? key, required this.budgets}) : super(key: key);
  final List<Budget> budgets;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    getStringRange(budgets[0].beginDate, budgets[0].endDate),
                    style: Theme.of(context).textTheme.headline4,
                  )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$totalAmount',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        '$totalRemain',
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  )
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).dividerColor,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: budgets.length,
              itemBuilder: (context, index) => BudgetItem(budget: budgets[index]),
            ),
          ],
        ),
      ),
    );
  }

  num get totalRemain {
    num spent = 0;
    num amount = 0;
    budgets.forEach((element) {
      spent += element.spent;
      amount += element.amount;
    });
    return amount - spent;
  }

  num get totalAmount {
    num amount = 0;
    budgets.forEach((element) {
      amount += element.amount;
    });
    return amount;
  }
}
