import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/data/models/budget.dart';

class BudgetItem extends StatelessWidget {
  BudgetItem({Key? key, required this.budget}) : super(key: key);
  final Budget budget;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 24, 16, 24),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 70,
                  child: Center(
                    child: icon,
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      budget.category?.name ?? 'All category'.tr,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      '${budget.beginDate.dayInMonth} - ${budget.endDate.dayInMonth}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SizedBox(
                  width: 70,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                            child: Text(
                          'Remaining'.tr,
                          style: Theme.of(context).textTheme.bodyText1,
                        )),
                        Text(
                          '${(budget.amount - budget.spent).money('\$')}',
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      ]),
                      Row(children: [
                        SizedBox(
                          width: 78,
                        ),
                        Expanded(child: SizedBox()),
                        Text(
                          '${budget.endDate.difference(DateTime.now()).inDays} ' + 'days left'.tr,
                          style: Theme.of(context).textTheme.subtitle2,
                        )
                      ]),
                      SizedBox(
                        height: 8,
                      ),
                      LinearProgressIndicator(
                        value: budget.spent / budget.amount,
                        color: progressColor(context, budget.spent / budget.amount),
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget get icon => budget.category == null || budget.category!.iconId.isEmpty
      ? Image(
          image: AssetImage(AssetStringsPng.electricity_bill),
          width: 30,
        )
      : Image.asset(
          "${budget.category!.iconId}",
          width: 30,
        );
}

Color progressColor(BuildContext context, double percentage) => percentage > 1 ? Colors.red : Theme.of(context).textTheme.button!.color!;
