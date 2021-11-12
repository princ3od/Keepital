import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class AdjustBalanceBody extends StatelessWidget {
  final String iconImgData;
  final String selectWalletTitle;
  final String enterCurrentBalance;
  final void Function() onPressed;
  final TextEditingController selectedWalletController;
  final TextEditingController currentBalanceController;
  AdjustBalanceBody({
    required this.iconImgData,
    required this.selectWalletTitle,
    required this.enterCurrentBalance,
    required this.onPressed,
    required this.selectedWalletController,
    required this.currentBalanceController,
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
          // IconButton(
          //   iconSize: 40,
          //   onPressed: onPressed,
          //   icon: (iconImgData == "")
          //       ? Icon(Icons.help)
          //       : ImageIcon(
          //           AssetImage('assets/in_app_icon/wallet_default.png'),
          //         ),
          // ),
          (iconImgData == "")
              ? IconButton(
                  icon: Icon(Icons.help),
                  onPressed: onPressed,
                  iconSize: 40,
                )
              : InkWell(
                  child: Container(padding: const EdgeInsets.all(8.0), child: Image.asset(iconImgData, width: 40, height: 40)),
                  onTap: onPressed,
                ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: selectedWalletController,
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
                    controller: currentBalanceController,
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
