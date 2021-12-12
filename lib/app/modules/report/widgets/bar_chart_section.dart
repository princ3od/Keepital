import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/report/report_controller.dart';

class BarChartSection extends StatelessWidget {
  const BarChartSection({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.transactions,
    required this.timeRange,
  }) : super(key: key);
  final DateTime startDate;
  final DateTime endDate;
  final List<TransactionModel> transactions;
  final TimeRange timeRange;
  @override
  Widget build(BuildContext context) {
    final data = ReportController.chartTimeData(transactions, DateTimeRange(start: startDate, end: endDate), timeRange);
    final bottomTiles = data.keys.toList();
    final values = data.values.toList();
    List<BarChartGroupData> rawBarGroups = [];
    List<BarChartGroupData> showingBarGroups = [];
    final minAndMax = ReportController.getMinAndMax(values);
    var min = Utils.nearestPowerOfTen(minAndMax[0].floorToDouble()), max = Utils.nearestPowerOfTen(minAndMax[1].floorToDouble());
    min = (min == 0) ? 1 : min;
    max = (max == 0) ? 1 : max;
    double minY = 0, maxY = 0;
    if (max >= min.abs()) {
      maxY = 1000;
      minY = (-1000 * (min / max).abs()).roundToDouble();
    } else {
      minY = -1000;
      maxY = (1000 * (max / min).abs()).roundToDouble();
    }
    for (var i = 0; i < values.length; i++) {
      rawBarGroups.add(makeGroupData(i, values[i][1] * maxY.abs() / max, values[i][0] * minY.abs() / -min, getColumnWidth(bottomTiles.length)));
    }

    showingBarGroups = rawBarGroups;
    return AspectRatio(
      aspectRatio: 1.2,
      child: BarChart(
        BarChartData(
          maxY: maxY,
          minY: minY,
          titlesData: FlTitlesData(
            show: true,
            rightTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false),
            bottomTitles: SideTitles(
              rotateAngle: 25,
              showTitles: true,
              margin: 20,
              getTextStyles: (context, value) => Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 9),
              getTitles: (double value) => bottomTiles[value.toInt()],
            ),
            leftTitles: SideTitles(
              showTitles: true,
              getTextStyles: (context, value) => Theme.of(context).textTheme.subtitle1,
              reservedSize: 50,
              margin: 10,
              interval: 1,
              getTitles: (value) {
                if (value == 0) {
                  return 0.money(DataService.currentWallet.value.currencySymbol);
                } else if (value == maxY) {
                  return max.compactCurrency(DataService.currentWallet.value.currencySymbol);
                } else if (value == minY) {
                  return (min * -1.0).compactCurrency(DataService.currentWallet.value.currencySymbol);
                } else if (value % 200 == 0) {
                  if (value > 0) {
                    return (value / maxY * max).compactCurrency(DataService.currentWallet.value.currencySymbol);
                  } else {
                    return (value / minY * min * -1.0).compactCurrency(DataService.currentWallet.value.currencySymbol);
                  }
                }
                return '';
              },
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 200,
            checkToShowHorizontalLine: (value) {
              return value % 2 == 0;
            },
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

  BarChartGroupData makeGroupData(int x, double y1, double y2, double width, [isIncome = true]) {
    return BarChartGroupData(barsSpace: -width, x: x, barRods: [
      BarChartRodData(y: y1, colors: [Colors.blue], width: width, borderRadius: BorderRadius.zero),
      BarChartRodData(y: y2, colors: [Colors.red], width: width, borderRadius: BorderRadius.zero),
    ]);
  }

  double getColumnWidth(int bottomeTileNumber) {
    final result = 160 / bottomeTileNumber;
    return (result < 16) ? 16 : result;
  }
}
