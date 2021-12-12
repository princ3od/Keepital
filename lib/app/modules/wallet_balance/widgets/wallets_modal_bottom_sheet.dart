import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/theme/app_theme.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/modules/home/widgets/wallet_item.dart';

class WalletsModalsBottomSheet extends StatefulWidget {
  final List<Wallet> wallets;
  final Function(Wallet selectedWallet) onSelect;

  const WalletsModalsBottomSheet({Key? key, required this.wallets, required this.onSelect}) : super(key: key);

  @override
  _WalletsModalsBottomSheetState createState() => _WalletsModalsBottomSheetState();
}

class _WalletsModalsBottomSheetState extends State<WalletsModalsBottomSheet> {
  Wallet total = Wallet('-1', name: 'Total'.tr, amount: 0.0, currencyId: '', iconId: '', currencySymbol: 'None_set');
  String selectedIndex = '-1';
  @override
  void initState() {
    super.initState();
    total.amount = widget.wallets.fold(0.0, (sum, wallet) => sum + wallet.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.currentTheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Wrap(children: [
          Column(
            children: [
              Text(
                'Select wallet'.tr,
                style: Theme.of(context).textTheme.headline5,
              ),
              WalletItem(
                wallet: total,
                selectedId: selectedIndex,
                onTap: () {},
              ),
              Divider(
                color: Theme.of(context).iconTheme.color,
              ),
              LimitedBox(
                maxHeight: 160,
                child: ListView.builder(
                    itemExtent: 50.0,
                    shrinkWrap: true,
                    itemCount: widget.wallets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return WalletItem(
                        wallet: widget.wallets[index],
                        selectedId: selectedIndex,
                        onTap: () => setState(() {
                          selectedIndex = widget.wallets[index].id.toString();
                          widget.onSelect(widget.wallets[index]);
                        }),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text('Go to My Wallets'.tr),
                  style: Theme.of(context).outlinedButtonTheme.style,
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
