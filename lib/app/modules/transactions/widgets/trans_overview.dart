import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class TransactionsOverview extends StatelessWidget {
  TransactionsOverview({Key? key, required this.inflow, required this.outflow}) : super(key: key);

  final num inflow;
  final num outflow;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Inflow'.tr, style: Theme.of(context).textTheme.bodyText1),
                Text(inflow.toString(), style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.blue)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Outflow'.tr, style: Theme.of(context).textTheme.bodyText1),
                Text(outflow.toString(), style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.red)),
              ],
            ),
            Divider(
              color: Theme.of(context).secondaryHeaderColor,
            ),
            Container(
              child: Text((inflow - outflow).toString(), style: Theme.of(context).textTheme.headline4),
              alignment: Alignment.centerRight,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextButton(onPressed: () {}, child: Text('View report for this period'.tr), style: Theme.of(context).textButtonTheme.style),
            )
          ],
        ),
      ),
    );
  }
}
