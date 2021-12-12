import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:keepital/app/core/utils/image_view.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/modules/report/report_controller.dart';

class PieChartSection extends StatelessWidget {
  const PieChartSection({Key? key, required this.incomeData, required this.expenseData}) : super(key: key);
  final Map<String, CategoryPercent> incomeData;
  final Map<String, CategoryPercent> expenseData;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: PieChartGroup(data: incomeData)),
        Expanded(child: PieChartGroup(data: expenseData)),
      ],
    );
  }
}

class PieChartGroup extends StatelessWidget {
  const PieChartGroup({Key? key, required this.data}) : super(key: key);
  final Map<String, CategoryPercent> data;
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  color: Colors.black.withOpacity(0.2),
                  showTitle: false,
                  value: 100,
                  radius: 8,
                ),
              ],
            ),
          ),
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
          size: 20,
          source: data[data.keys.elementAt(i)]!.category.iconId,
        ),
        badgePositionPercentageOffset: 1,
      ));
    }
    return result;
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
      child: ImageView(
        source,
        size: size,
        fit: BoxFit.contain,
      ),
    );
  }
}
