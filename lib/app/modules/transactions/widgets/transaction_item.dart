import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/routes/pages.dart';

class TransactionItem extends StatelessWidget {
  TransactionItem({Key? key, required TransactionModel transaction})
      : trans = transaction,
        super(key: key);

  final TransactionModel trans;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        Get.toNamed(Routes.transactionDetail, arguments: trans);
      },
      leading: Image(image: AssetImage('assets/images/wallet_list_icon.png')),
      title: Text(
        trans.category.name,
        style: Theme.of(context).textTheme.headline6,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        trans.note.toString(),
        style: Theme.of(context).textTheme.subtitle2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(trans.amount.toString(),
          style: Theme.of(context).textTheme.headline6!.apply(
                color: trans.category.type == CategoryType.income ? Colors.blue : Colors.red,
              )),
      dense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 9.0),
    );
  }
}
