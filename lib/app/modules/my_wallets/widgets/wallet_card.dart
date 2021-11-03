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
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 17,
                  ),
                  Icon(Icons.wallet_travel),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${wallet.name}"),
                      Text("${wallet.amount}"),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.more_vert),
                  SizedBox(
                    width: 25,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
