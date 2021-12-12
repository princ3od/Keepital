import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/global_widgets/section_panel.dart';

class TransactionsOverview extends StatelessWidget {
  TransactionsOverview({Key? key, required this.inflow, required this.outflow}) : super(key: key);

  final num inflow;
  final num outflow;

  @override
  Widget build(BuildContext context) {
    return SectionPanel(
      padding: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Inflow'.tr, style: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).hintColor)),
                Text(inflow.readable, style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.blue)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Outflow'.tr, style: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).hintColor)),
                Text(outflow.readable, style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.red)),
              ],
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              thickness: 1,
            ),
            Container(
              child: Text((inflow - outflow).money(DataService.currentUser!.currencySymbol), style: Theme.of(context).textTheme.headline4),
              alignment: Alignment.centerRight,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'View report for this period'.tr,
                  style: Theme.of(context).textTheme.button,
                ),
                style: Theme.of(context).textButtonTheme.style,
              ),
            )
          ],
        ),
      ),
    );
  }
}
