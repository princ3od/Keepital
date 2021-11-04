import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class AdjustBalanceBody extends StatelessWidget {
  final IconData iconData;
  final String selectWalletTitle;
  final String enterCurrentBalance;
  AdjustBalanceBody({
    required this.iconData,
    required this.selectWalletTitle,
    required this.enterCurrentBalance,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.backgroundColor,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 8,
          ),
          IconButton(
            iconSize: 40,
            onPressed: null,
            icon: Icon(iconData),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: selectWalletTitle,
                    labelStyle: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: enterCurrentBalance,
                      labelStyle: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
