import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keepital/app/data/models/Transaction.dart';
import 'package:keepital/app/modules/transactions/widgets/transaction_item.dart';

class TransactionContainer extends StatelessWidget {
  TransactionContainer({Key? key, required List<Transaction> transaction})
      : _transaction = transaction,
        super(key: key);

  final List<Transaction> _transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text('27', style: Theme.of(context).textTheme.headline3),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monday',
                          style: Theme.of(context).textTheme.bodyText2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'October 2020',
                          style: Theme.of(context).textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
                Text('10.000', style: Theme.of(context).textTheme.headline6),
              ],
            ),
            Divider(
              height: 2,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemExtent: 55,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _transaction.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TransactionItem(
                      transaction: _transaction[index],
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
