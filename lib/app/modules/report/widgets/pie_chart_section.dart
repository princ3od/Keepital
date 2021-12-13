import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/image_view.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/assets.gen.dart';
import 'package:keepital/app/modules/report/report_controller.dart';

class PieChartSection extends StatelessWidget {
  const PieChartSection({
    Key? key,
    required this.incomeData,
    required this.expenseData,
    required this.income,
    required this.expense,
  }) : super(key: key);
  final Map<String, CategoryPercent> incomeData;
  final Map<String, CategoryPercent> expenseData;
  final double income;
  final double expense;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: incomeData.isNotEmpty ? () {} : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Income'.tr,
                      style: Theme.of(context).textTheme.headline6!.copyWith(color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity + 0.2)),
                    ),
                    const SizedBox(height: 4),
                    Text(income.readable, style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 16.5, fontWeight: FontWeight.w600, color: Colors.blue)),
                    PieChartGroup(data: incomeData),
                  ],
                ),
              ),
              PieChartDescription(data: incomeData),
              const SizedBox(height: 48),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: expenseData.isNotEmpty ? () {} : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expense'.tr,
                      style: Theme.of(context).textTheme.headline6!.copyWith(color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity + 0.2)),
                    ),
                    const SizedBox(height: 4),
                    Text(expense.readable, style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 16.5, fontWeight: FontWeight.w600, color: Colors.red)),
                    PieChartGroup(data: expenseData),
                  ],
                ),
              ),
              PieChartDescription(data: expenseData),
              const SizedBox(height: 38)
            ],
          ),
        ),
      ],
    );
  }
}

class PieChartGroup extends StatelessWidget {
  const PieChartGroup({Key? key, required this.data}) : super(key: key);
  final Map<String, CategoryPercent> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  startDegreeOffset: 270,
                  sectionsSpace: 0,
                  centerSpaceRadius: 24,
                  sections: convertData(),
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  startDegreeOffset: 270,
                  sectionsSpace: 0,
                  centerSpaceRadius: 24,
                  sections: [
                    PieChartSectionData(
                      color: Colors.black.withOpacity(0.24),
                      showTitle: false,
                      value: 100,
                      radius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> convertData() {
    if (data.isEmpty) {
      return [
        PieChartSectionData(
          color: AppColors.textColor.withOpacity(.3),
          showTitle: false,
          value: 100,
          radius: 24,
        )
      ];
    }
    int colorNumber = AppColors.pieChartCategoryColors.length;

    final List<PieChartSectionData> result = [];
    for (var i = 0; i < data.keys.length; i++) {
      result.add(PieChartSectionData(
        color: AppColors.pieChartCategoryColors[i % colorNumber],
        showTitle: false,
        value: data[data.keys.elementAt(i)]!.percent,
        radius: 24,
        badgeWidget: Bagde(
          borderColor: AppColors.textColor,
          size: 24,
          source: data[data.keys.elementAt(i)]!.category.iconId,
        ),
        badgePositionPercentageOffset: 1,
      ));
    }
    return result;
  }
}

class PieChartDescription extends StatelessWidget {
  const PieChartDescription({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, CategoryPercent> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: data.keys.length,
        itemBuilder: (context, index) {
          final colorNumber = AppColors.pieChartCategoryColors.length;
          final key = data.keys.elementAt(index);
          final value = data[key];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.pieChartCategoryColors[index % colorNumber],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5 - 60,
                  child: Text(
                    value!.category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class Bagde extends StatelessWidget {
  const Bagde({Key? key, required this.source, required this.size, required this.borderColor}) : super(key: key);
  final String source;
  final double size;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor.withOpacity(0.5),
          width: 1.2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: source.isEmpty
          ? Assets.inAppIconElectricityBill.image()
          : ImageView(
              source,
              size: size,
              fit: BoxFit.contain,
            ),
    );
  }
}
