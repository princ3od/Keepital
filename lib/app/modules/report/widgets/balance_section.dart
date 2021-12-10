import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_colors.dart';

class BalanceSection extends StatelessWidget {
  const BalanceSection({
    Key? key,
    required this.openingAmount,
    required this.closingAmount,
  }) : super(key: key);
  final double openingAmount;
  final double closingAmount;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Balance'.tr, style: Theme.of(context).textTheme.headline3),
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
                  Text(openingAmount.readable, style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 18)),
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
                  Text(closingAmount.readable, style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
