import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/theme/app_theme.dart';
import 'package:keepital/app/core/values/app_colors.dart';

class TransactionsOverview extends StatelessWidget {
  const TransactionsOverview({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Inflow', style: Theme.of(context).textTheme.bodyText1),
              Text('1.200.000', style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.blue)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Outflow', style: Theme.of(context).textTheme.bodyText1),
              Text('1.200.000', style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.red),),
            ],
          ),
          Divider(height: 0, color: Theme.of(context).secondaryHeaderColor,),
          Container(child: Text('1.200.000', style: Theme.of(context).textTheme.bodyText1), alignment: Alignment.centerRight,),
          TextButton(onPressed: () {}, child: Text('View report for this period'),)
        ],),
      ),
    );
  }
}