import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/routes/pages.dart';

class TransactionDateItem extends StatelessWidget {
  TransactionDateItem({Key? key, required TransactionModel transaction})
      : trans = transaction,
        super(key: key);

  final TransactionModel trans;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Get.toNamed(Routes.transactionDetail, arguments: trans);
      },
      child: Row(
        children: [
          Container(
            width: 45,
            padding: EdgeInsets.only(left: 5, right: 10),
            child: Text(trans.date.onlyDate, style: Theme.of(context).textTheme.headline2),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  trans.date.monthNDay,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                trans.note.toString(),
                style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Theme.of(context).hintColor),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )),
          Text(trans.amount.readable,
              style: Theme.of(context).textTheme.headline6!.apply(
                    color: trans.category.type == CategoryType.income ? Colors.blue : Colors.red,
                  )),
        ],
      ),
    );
  }
}
