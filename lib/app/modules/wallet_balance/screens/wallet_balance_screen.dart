import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/modules/wallet_balance/widgets/adjust_balance_body.dart';
import 'package:get/get.dart';
import 'package:keepital/app/modules/wallet_balance/widgets/exclude_setting.dart';

class WalletBalanceScreen extends StatefulWidget {
  const WalletBalanceScreen({Key? key}) : super(key: key);

  @override
  _WalletBalanceScreenState createState() => _WalletBalanceScreenState();
}

class _WalletBalanceScreenState extends State<WalletBalanceScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: AppColors.appbarColouredBorder,
                height: 4.0,
              ),
              preferredSize: Size.fromHeight(3.0)),
          leading: IconButton(
            color: Colors.black,
            onPressed: () {},
            icon: Icon(Icons.close),
            iconSize: 24,
          ),
          title: Text(
            "Adjust Balance".tr,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                "SAVE".tr,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith((states) => AppColors.appbarColouredBorder.withOpacity(0.3)),
              ),
            ),
          ],
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                AdjustBalanceBody(
                  enterCurrentBalance: 'Enter curent balance'.tr,
                  iconData: Icons.help,
                  selectWalletTitle: 'Select Wallet'.tr,
                ),
                SizedBox(
                  height: 12,
                ),
                ExcludeSetting(
                  title: 'Exclude from report'.tr,
                  subtitle: 'This transaction is not included in Report and Overview.'.tr,
                  onTap: (isChecked) {
                    print(isChecked);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
