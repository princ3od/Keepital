import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/data/models/budget.dart';
import 'package:keepital/app/global_widgets/detail_view_appbar.dart';
import 'package:keepital/app/modules/budget/budget_detail_controller.dart';

class BudgetDetailScreen extends StatelessWidget {
  BudgetDetailScreen({Key? key, required this.budget}) : super(key: key);
  final controller = Get.put(BudgetDetailController());
  final Budget budget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailViewAppbar(
        onDeletePressed: () => controller.onDeleteBudget(budget),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: leadingWidth,
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
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Text(
                                budget.amount.money('\$'),
                                style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.blue),
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
                            width: leadingWidth,
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
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: leadingWidth,
                            child: Center(
                              child: Icon(
                                Icons.calendar_today,
                                size: 50,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${budget.beginDate.numbericDate} - ${budget.endDate.numbericDate}',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Text(
                                '${budget.endDate.difference(DateTime.now()).inDays} ' + 'days left'.tr,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get icon => budget.category == null || budget.category!.iconId.isEmpty
      ? Image(
          image: AssetImage(AssetStringsPng.electricity_bill),
          width: 50,
        )
      : Image.asset(
          "${budget.category!.iconId}",
          width: 50,
        );
}

Color progressColor(BuildContext context, double percentage) => percentage > 1 ? Colors.red : Theme.of(context).textTheme.button!.color!;
double get leadingWidth => 80;
