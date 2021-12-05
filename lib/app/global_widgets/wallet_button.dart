import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/global_widgets/wallet_selector.dart';

class WalletButton extends StatefulWidget {
  WalletButton({Key? key, this.onWalletChange}) : super(key: key);

  final Function(String)? onWalletChange;

  @override
  State<WalletButton> createState() => _WalletButtonState();
}

class _WalletButtonState extends State<WalletButton> {
  String currentWalletId = DataService.currentWallet.value.id!;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () async {
        showWalletsModalBottomSheet(context, selectedId: currentWalletId, onSelectWallet: (id) {
          setState(() {
            currentWalletId = id;
          });
          DataService.onCurrentWalletChange(id);
          widget.onWalletChange?.call(id);
        });
      },
      child: Row(
        children: [
          Container(
            child: currentWalletId.isEmpty
                ? Image(
                    image: AssetImage(AssetStringsPng.walletList),
                    height: 30,
                  )
                : Image.asset(
                    "${wallet(currentWalletId).iconId}",
                    height: 30,
                  ),
          ),
          Icon(Icons.arrow_drop_down, color: Theme.of(context).iconTheme.color)
        ],
      ),
    );
  }
}

Wallet wallet(String id) {
  if (id.isEmpty) return DataService.total;
  return DataService.currentUser!.wallets[id] ?? DataService.total;
}
