import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/home/home_controller.dart';

class TransactionDetailBody extends StatelessWidget {
  TransactionDetailBody({Key? key, required TransactionModel trans})
      : _trans = trans,
        super(key: key);

  final HomeController _controller = Get.find<HomeController>();

  final TransactionModel _trans;

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
              leading: Image(
                image: AssetImage(AssetStringsPng.electricity_bill),
                height: 40,
              ),
              title: Text(_trans.category.name, style: Theme.of(context).textTheme.headline6),
            ),
            Container(alignment: Alignment.centerLeft, padding: EdgeInsets.only(left: 72.0), child: Text(_trans.amount.readable, style: Theme.of(context).textTheme.headline3!.copyWith(color: _trans.category.type == CategoryType.expense ? Colors.red : Colors.blue))),
            ListTile(
              leading: Icon(Icons.description),
              title: Text(_trans.note.toString(), style: Theme.of(context).textTheme.bodyText1),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(_trans.date.fullDate, style: Theme.of(context).textTheme.bodyText1),
            ),
            ListTile(
              leading: Image(
                image: AssetImage(AssetStringsPng.walletList),
                height: 30,
              ),
              title: Text(_controller.currentWallet.value.name, style: Theme.of(context).textTheme.bodyText1),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Wrap(
                spacing: 10.0,
                children: List.generate(3, (index) => Chip(label: Text('Hoang Anh'))),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
