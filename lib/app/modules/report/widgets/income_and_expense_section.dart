import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/modules/report/widgets/net_bar_chart.dart';

class IncomeAndExpenseSection extends StatelessWidget {
  const IncomeAndExpenseSection({Key? key, required this.netIncome}) : super(key: key);
  final double netIncome;
  @override
  Widget build(BuildContext context) {
    late List<BarChartGroupData> rawBarGroups;
    late List<BarChartGroupData> showingBarGroups;
    final barGroup1 = makeGroupData(0, 14, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text('Income & Expense'.tr, style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 20)),
        const SizedBox(height: 8),
        Text('Net Income'.tr,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity + 0.2),
                )),
        const SizedBox(height: 4),
        Text(netIncome.readable, style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 16.5, fontWeight: FontWeight.w600)),
        const SizedBox(height: 24),
        NetBarChart(showingBarGroups: showingBarGroups),
      ],
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2, [isIncome = true]) {
    return BarChartGroupData(barsSpace: -16, x: x, barRods: [
      BarChartRodData(y: y1, colors: [Colors.blue], width: 16, borderRadius: BorderRadius.zero),
      BarChartRodData(y: -y2, colors: [Colors.red], width: 16, borderRadius: BorderRadius.zero),
    ]);
  }
}
