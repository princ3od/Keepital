import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';

class TransactionDetailBody extends StatelessWidget {
  TransactionDetailBody({Key? key, required this.trans}) : super(key: key) {
     peoples = stringToList(trans.contact);
  }

  final TransactionModel trans;
  late final List<String> peoples;

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Wrap(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: isIconEmpty
                  ? Image(
                      image: AssetImage(AssetStringsPng.electricity_bill),
                      height: 40,
                    )
                  : Image.asset(
                      trans.category.iconId,
                      height: 30,
                    ),
              title: Text(trans.category.name, style: Theme.of(context).textTheme.headline6),
            ),
            Container(alignment: Alignment.centerLeft, padding: EdgeInsets.only(left: 72.0), child: Text(trans.amount.readable, style: Theme.of(context).textTheme.headline3!.copyWith(color: amountColor))),
            Visibility(
              visible: haveNote,
              child: ListTile(
                leading: Icon(Icons.description),
                title: Text(trans.note.toString(), style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(trans.date.fullDate, style: Theme.of(context).textTheme.bodyText1),
            ),
            ListTile(
              leading: Image(
                image: AssetImage(AssetStringsPng.walletList),
                height: 30,
              ),
              title: Text(isLoadedWalletId ? walletName : 'Failed', style: Theme.of(context).textTheme.bodyText1),
            ),
            Visibility(
              visible: isPayWithOthers,
              child: ListTile(
                leading: Icon(Icons.people),
                title: Wrap(
                  spacing: 10.0,
                  children: List.generate(peoples.length, (index) => Chip(label: Text(peoples[index]))),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  bool get haveNote => trans.note != null && trans.note != '';
  bool get isPayWithOthers => peoples.length > 0;
  bool get isLoadedWalletId => trans.walletId != null;
  bool get isIconEmpty => trans.category.iconId.isEmpty;
  Color get amountColor => trans.category.type == CategoryType.expense ? Colors.red : Colors.blue;
  String get walletId => trans.walletId!;
  String get walletName => DataService.currentUser!.wallets[walletId]?.name ?? 'Failed';
}
