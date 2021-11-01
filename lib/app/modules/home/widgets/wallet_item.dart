import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepital/app/data/models/wallet.dart';

class WalletItem extends StatelessWidget {
  WalletItem({Key? key, required Wallet wallet, void Function()? onTap, String? selectedId})
      : _wallet = wallet,
        _onTap = onTap,
        _selectedId = selectedId,
        super(key: key);

  final Wallet _wallet;
  final void Function()? _onTap;
  final String? _selectedId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Image(
        image: AssetImage('assets/images/wallet_list_icon.png'),
        height: 30,
      ),
      title: Text(
        _wallet.name,
        style: Theme.of(context).textTheme.headline6,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        _wallet.amount.toString(),
        style: Theme.of(context).textTheme.bodyText1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Visibility(
        child: Icon(Icons.check_circle, color: Theme.of(context).iconTheme.color),
        visible: _selectedId == _wallet.id,
      ),
      onTap: _onTap,
    );
  }
}
