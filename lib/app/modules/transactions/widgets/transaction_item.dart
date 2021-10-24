import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/data/models/Transaction.dart';
import 'package:keepital/app/routes/pages.dart';

class TransactionItem extends StatelessWidget {
  TransactionItem({Key? key, required Transaction transaction})
      : trans = transaction,
        super(key: key);

  final Transaction trans;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        Get.toNamed(Routes.transactionDetail, arguments: trans);
      },
      leading: Image(image: AssetImage('assets/images/wallet_list_icon.png')),
      title: Text(
        trans.Category,
        style: Theme.of(context).textTheme.headline6,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        trans.Note.toString(),
        style: Theme.of(context).textTheme.subtitle2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(trans.Amount.toString(),
          style: Theme.of(context).textTheme.headline6!.apply(
                color: trans.Type == TransactionType.Inflow ? Colors.blue : Colors.red,
              )),
      dense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 9.0),
    );
  }
}
