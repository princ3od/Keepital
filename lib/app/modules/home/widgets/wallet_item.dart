import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletItem extends StatelessWidget {
  const WalletItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      child: Row(
        children: [
          Container(
              child: Image(
            image: AssetImage('assets/images/wallet_list_icon.png'),
            height: 30,
          )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wallet name',
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '100000000',
                    style: Theme.of(context).textTheme.caption,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
          Visibility(
            child: Icon(Icons.check_circle,
                color: Theme.of(context).iconTheme.color),
            visible: true,
          ),
        ],
      ),
    );
  }
}
