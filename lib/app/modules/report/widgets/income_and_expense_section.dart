import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_colors.dart';

class IncomeAndExpenseSection extends StatelessWidget {
  const IncomeAndExpenseSection({Key? key, required this.netIncome}) : super(key: key);
  final double netIncome;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text('Income & Expense'.tr, style: Theme.of(context).textTheme.headline3),
        const SizedBox(height: 8),
        Text('Net Income'.tr,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity + 0.2),
                )),
        const SizedBox(height: 4),
        Text(netIncome.readable, style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 16.5, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 1.2,
          child: BarChart(
            BarChartData(
              maxY: 20,
              titlesData: FlTitlesData(
                show: true,
                rightTitles: SideTitles(showTitles: false),
                topTitles: SideTitles(showTitles: false),
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context, value) => Theme.of(context).textTheme.headline5,
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'Mn';
                      case 1:
                        return 'Te';
                      case 2:
                        return 'Wd';
                      case 3:
                        return 'Tu';
                      case 4:
                        return 'Fr';
                      case 5:
                        return 'St';
                      case 6:
                        return 'Sn';
                      default:
                        return '';
                    }
                  },
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context, value) => Theme.of(context).textTheme.headline6!,
                  reservedSize: 28,
                  interval: 1,
                  getTitles: (value) {
                    if (value == 0) {
                      return '1K';
                    } else if (value == 10) {
                      return '5K';
                    } else if (value == 19) {
                      return '10K';
                    } else {
                      return '';
                    }
                  },
                ),
              ),
              gridData: FlGridData(
                show: true,
                checkToShowHorizontalLine: (value) => value % 2 == 0,
                getDrawingHorizontalLine: (value) => FlLine(
                  strokeWidth: 1,
                ),
                drawHorizontalLine: true,
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  top: BorderSide(
                    width: 1,
                  ),
                  bottom: BorderSide(
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
