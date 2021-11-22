import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/transactions/widgets/transaction_item.dart';

class TransactionByDateContainer extends StatelessWidget {
  TransactionByDateContainer({Key? key, required this.transList}) : super(key: key);

  final List<TransactionModel> transList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Container(width: 35, child: Center(child: Text(transList[0].date.onlyDate, style: Theme.of(context).textTheme.headline1))),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Text(
                            transList[0].date.dayInWeek,
                            style: Theme.of(context).textTheme.headline5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          transList[0].date.fullMonth,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).hintColor),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
                Text(totalCalculation(transList).readable, style: Theme.of(context).textTheme.headline6),
              ],
            ),
          ),
          Divider(
            height: 2,
            color: Theme.of(context).dividerColor,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemExtent: 55,
              physics: NeverScrollableScrollPhysics(),
              itemCount: transList.length,
              itemBuilder: (BuildContext context, int index) {
                return TransactionItem(
                  transaction: transList[index],
                );
              }),
        ],
      ),
    );
  }
}

num totalCalculation(List<TransactionModel> transList) {
  num total = 0;
  for (var trans in transList) {
    if (trans.category.type == CategoryType.income) {
      total += trans.amount;
    } else if (trans.category.type == CategoryType.expense) {
      total -= trans.amount;
    }
  }
  return total;
}
