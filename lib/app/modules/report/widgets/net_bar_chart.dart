import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:keepital/app/core/values/app_colors.dart';

class NetBarChart extends StatelessWidget {
  const NetBarChart({
    Key? key,
    required this.showingBarGroups,
  }) : super(key: key);

  final List<BarChartGroupData> showingBarGroups;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            show: true,
            rightTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false),
            bottomTitles: SideTitles(
              showTitles: true,
              margin: 10,
              getTextStyles: (context, value) => Theme.of(context).textTheme.subtitle1,
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
              getTextStyles: (context, value) => Theme.of(context).textTheme.subtitle1,
              reservedSize: 20,
              margin: 10,
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
            drawVerticalLine: false,
            checkToShowHorizontalLine: (value) => value % 2 == 0,
            getDrawingHorizontalLine: (value) => FlLine(
              color: AppColors.textColor.withOpacity(0.25),
              strokeWidth: 0.8,
            ),
            drawHorizontalLine: true,
          ),
          barGroups: showingBarGroups,
          borderData: FlBorderData(
            show: true,
            border: Border(
              top: BorderSide(
                color: AppColors.textColor.withOpacity(0.25),
                width: 0.8,
              ),
              bottom: BorderSide(
                color: AppColors.textColor.withOpacity(0.25),
                width: 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
