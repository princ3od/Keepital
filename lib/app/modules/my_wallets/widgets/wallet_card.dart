import 'package:flutter/material.dart';
import 'package:keepital/app/core/theme/app_theme.dart';
import 'package:keepital/app/core/utils/image_view.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/data/models/wallet.dart';

class WalletCard extends StatelessWidget {
  WalletCard({required this.wallet, this.onTap});
  final VoidCallback? onTap;
  final Wallet wallet;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 8,
      tileColor: AppColors.backgroundColor,
      onTap: onTap,
      leading: ImageView(
        wallet.iconId,
        size: 32,
      ),
      title: Text(
        wallet.name,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        '${wallet.amount.money(wallet.currencySymbol)}',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity + 0.2)),
      ),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert, color: AppColors.textColor)),
    );

    return Material(
      color: AppTheme.currentTheme.backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
