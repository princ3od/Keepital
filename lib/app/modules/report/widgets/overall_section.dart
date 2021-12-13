import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_colors.dart';

class OverallSection extends StatelessWidget {
  const OverallSection({
    Key? key,
    required this.openingAmount,
    required this.closingAmount,
    required this.netIncome,
  }) : super(key: key);
  final double openingAmount;
  final double closingAmount;
  final double netIncome;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Balance'.tr, style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 20)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Opening balance'.tr,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity + 0.2),
                          )),
                  const SizedBox(height: 4),
                  Text(openingAmount.readable, style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 16.5, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Closing balance'.tr,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity + 0.2),
                          )),
                  const SizedBox(height: 4),
                  Text(
                    closingAmount.readable,
                    style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 16.5, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Divider(thickness: 1, color: Theme.of(context).dividerColor),
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
      ],
    );
  }
}
