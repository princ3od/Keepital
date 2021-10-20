import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/models/Transaction.dart';
import 'package:keepital/app/modules/transaction_detail/widgets/transaction_detail_appbar.dart';
import 'package:keepital/app/modules/transaction_detail/widgets/transaction_detail_body.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Transaction _trans = Get.arguments;

    return Scaffold(
      appBar: TransactionDetailAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: TransactionDetailBody(
              trans: _trans,
            ),
            alignment: Alignment.topCenter,
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                'Money tip:'.tr,
                style: Theme.of(context).textTheme.bodyText1,
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'You can create a budget for this category to be better financial management.'.tr,
                style: Theme.of(context).textTheme.button,
              )),
          Container(
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: OutlinedButton(
                onPressed: () {},
                child: Text('Create budget for this month'.tr),
                style: Theme.of(context).outlinedButtonTheme.style),
          )
        ],
      ),
    );
  }
}
