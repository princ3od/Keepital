import 'package:flutter/material.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/report/report_controller.dart';

class CategorySpending extends StatelessWidget {
  const CategorySpending({Key? key, required this.categoryPercent}) : super(key: key);
  final CategoryPercent categoryPercent;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: -8),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          categoryPercent.category.iconId.isEmpty
              ? Image(
                  image: AssetImage(AssetStringsPng.electricity_bill),
                  width: 30,
                )
              : Image.asset(
                  "${categoryPercent.category.iconId}",
                  width: 30,
                ),
        ],
      ),
      title: Text("${categoryPercent.category.name}", style: Theme.of(context).textTheme.headline5),
      trailing: Text("${categoryPercent.realAmount.readable}",
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w600,
                color: (categoryPercent.category.type == CategoryType.expense) ? Colors.red : Colors.blue,
              )),
    );
  }
}
