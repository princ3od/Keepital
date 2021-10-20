import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/data/models/Transaction.dart';

class TransactionDetailBody extends StatelessWidget {
  TransactionDetailBody({Key? key, required Transaction trans}) : _trans = trans, super(key: key);

  Transaction _trans;

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
              title: Text(_trans.Category,
                  style: Theme.of(context).textTheme.headline6),
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 72.0),
                child: Text(_trans.Amount.toString(),
                    style: GoogleFonts.montserrat(
                        color: _trans.Type == TransactionType.Outflow ? Colors.red : Colors.blue, fontSize: 20))),
            ListTile(
              leading: Icon(Icons.description),
              title: Text(_trans.Note.toString(),
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Monday,  27 October 2021',
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            ListTile(
              leading: Image(
                image: AssetImage(AssetStringsPng.walletList),
                height: 30,
              ),
              title: Text('Wallet name',
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Wrap(
                spacing: 10.0,
                children: List.generate(
                    3, (index) => Chip(label: Text('Hoang Anh'))),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
