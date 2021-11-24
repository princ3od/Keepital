import 'package:flutter/material.dart';
import 'package:keepital/app/core/utils/image_view.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/data/models/wallet.dart';

class WalletCard extends StatelessWidget {
  WalletCard({required this.wallet, this.onTap, this.onDelete});
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
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
      trailing: IconButton(onPressed: onDelete, icon: Icon(Icons.delete, color: AppColors.textColor)),
    );
  }
}
