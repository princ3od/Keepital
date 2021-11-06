import 'package:flutter/material.dart';
import 'package:keepital/app/core/theme/app_theme.dart';
import 'package:keepital/app/data/models/wallet.dart';

class WalletCard extends StatelessWidget {
  final VoidCallback? onTap;
  final Wallet wallet;
  WalletCard({required this.wallet, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.currentTheme.backgroundColor,
      child: InkWell(
        splashColor: AppTheme.currentTheme.splashColor,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    "${wallet.iconId}",
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${wallet.name}"),
                      Text("${wallet.amount} ${wallet.currencySymbol}"),
                    ],
                  ),
                ],
              ),
              Icon(Icons.more_vert),
            ],
          ),
        ),
      ),
    );
  }
}
