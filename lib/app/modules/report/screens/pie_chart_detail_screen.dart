import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/report/report_controller.dart';
import 'package:keepital/app/modules/report/widgets/category_spending.dart';
import 'package:keepital/app/modules/report/widgets/pie_chart_section.dart';

class PieChartDetailScreen extends StatelessWidget {
  const PieChartDetailScreen({Key? key, required this.totalAmount, required this.type, required this.data}) : super(key: key);
  final double totalAmount;
  final CategoryType type;
  final Map<String, CategoryPercent> data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (type == CategoryType.expense) ? 'Expense'.tr : 'Income'.tr,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Hero(
            tag: totalAmount.hashCode.toString(),
            child: Material(
              color: Colors.transparent,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total'.tr,
                          style: Theme.of(context).textTheme.headline6!.copyWith(color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity + 0.2)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          totalAmount.readable,
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: (type == CategoryType.expense) ? Colors.red : Colors.blue,
                              ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: PieChartGroup(
                        data: data,
                        centerRadius: 32,
                        radius: 40,
                        badgeSize: 28,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final colorNumber = AppColors.pieChartCategoryColors.length;
                        final key = data.keys.elementAt(index);
                        final value = data[key];
                        final color = AppColors.pieChartCategoryColors[index % colorNumber];
                        return DescriptionItem(color: color, size: 16, percent: value!.percent, description: value.category.name);
                      },
                    ),
                    Divider(color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity), thickness: 1),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) => CategorySpending(categoryPercent: data.values.elementAt(index)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DescriptionItem extends StatelessWidget {
  const DescriptionItem({
    Key? key,
    required this.color,
    required this.size,
    required this.percent,
    required this.description,
  }) : super(key: key);
  final Color color;
  final double size;
  final double percent;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 48, vertical: -8),
      dense: true,
      horizontalTitleGap: -8,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
      title: Text(
        description,
        style: Theme.of(context).textTheme.headline4!.copyWith(color: color),
      ),
      trailing: Text(
        percent.toStringAsFixed(2) + '%',
        style: Theme.of(context).textTheme.headline6!.copyWith(color: color),
      ),
    );
  }
}
