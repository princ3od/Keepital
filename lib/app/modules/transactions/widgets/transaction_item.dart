import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/data/models/Transaction.dart';

class TransactionItem extends StatelessWidget {
  TransactionItem({Key? key, required Transaction transaction})
      : trans = transaction,
        super(key: key);

  final Transaction trans;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      height: 55.0,
      child: Row(
        children: [
          Container(
              child: Image(
            image: AssetImage('assets/images/wallet_list_icon.png'),
            height: 30,
          )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trans.Category,
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    trans.Note.toString(),
                    style: Theme.of(context).textTheme.caption,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
          Text(
            trans.Amount.toString(),
            style: GoogleFonts.montserrat(color: trans.Type == TransactionType.Inflow ? Colors.blue : Colors.red, fontWeight: FontWeight.w400)
          )
        ],
      ),
    );
  }
}
