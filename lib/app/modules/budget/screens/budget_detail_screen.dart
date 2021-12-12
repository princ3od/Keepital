import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/data/models/budget.dart';
import 'package:keepital/app/global_widgets/detail_view_appbar.dart';
import 'package:keepital/app/global_widgets/section_panel.dart';
import 'package:keepital/app/modules/budget/budget_detail_controller.dart';

class BudgetDetailScreen extends StatefulWidget {
  BudgetDetailScreen({Key? key, required this.budget}) : super(key: key);
  final Budget budget;

  @override
  State<BudgetDetailScreen> createState() => _BudgetDetailScreenState();
}

class _BudgetDetailScreenState extends State<BudgetDetailScreen> {
  final controller = Get.put(BudgetDetailController());

  @override
  void initState() {
    super.initState();
    controller.budget = widget.budget.obs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailViewAppbar(
        onDeletePressed: () => controller.onDeleteBudget(controller.budget.value),
        onEditPressed: () => controller.onEditBudget(controller.budget.value),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
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
                        Obx(() => Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.budget.value.category?.name ?? 'All category'.tr,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                Text(
                                  controller.budget.value.amount.money('\$'),
                                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.blue),
                                ),
                              ],
                            ))),
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
                              Obx(() => Row(children: [
                                    Expanded(
                                        child: Text(
                                      'Remaining'.tr,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    )),
                                    Text(
                                      '${(controller.budget.value.amount - controller.budget.value.spent).money(currencySymbol(controller.budget.value.walletId))}',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    )
                                  ])),
                              Obx(() => Row(children: [
                                    Expanded(child: SizedBox()),
                                    Text(
                                      '${controller.budget.value.endDate.difference(DateTime.now()).inDays} ' + 'days left'.tr,
                                      style: Theme.of(context).textTheme.subtitle2,
                                    )
                                  ])),
                              SizedBox(
                                height: 8,
                              ),
                              Obx(() => LinearProgressIndicator(
                                    value: controller.budget.value.spent / controller.budget.value.amount,
                                    color: progressColor(context, controller.budget.value.spent / controller.budget.value.amount),
                                    backgroundColor: AppColors.textColor.withOpacity(AppColors.disabledIconOpacity),
                                  ))
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
                            child: Obx(() => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${controller.budget.value.beginDate.numbericDate} - ${controller.budget.value.endDate.numbericDate}',
                                      style: Theme.of(context).textTheme.headline5,
                                    ),
                                    Text(
                                      '${controller.budget.value.endDate.difference(DateTime.now()).inDays} ' + 'days left'.tr,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get icon => widget.budget.category == null || widget.budget.category!.iconId.isEmpty
      ? Image(
          image: AssetImage(AssetStringsPng.electricity_bill),
          width: 50,
        )
      : Image.asset(
          "${widget.budget.category!.iconId}",
          width: 50,
        );
}

Color progressColor(BuildContext context, double percentage) => percentage > 1 ? Colors.red : Theme.of(context).textTheme.button!.color!;
double get leadingWidth => 80;
