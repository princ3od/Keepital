import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/modules/home/widgets/wallet_item.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  TopBar(
      {Key? key,
      required TabController tabController,
      required List<Text> tabs})
      : preferedSize = Size.fromHeight(100),
        _tabController = tabController,
        _tabs = tabs,
        super(key: key);

  final Size preferedSize;
  final TabController _tabController;
  final List<Text> _tabs;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      title: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              ShowWalletsModalBottomSheet(context);
            },
            child: Row(
              children: [
                Container(
                    child: Image(
                  image: AssetImage(AssetStringsPng.walletList),
                  height: 30,
                )),
                Icon(Icons.arrow_drop_down,
                    color: Theme.of(context).iconTheme.color)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wallet name',
                  style: Theme.of(context).textTheme.caption,
                ),
                Text('15.000.000', style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
          )
        ],
      ),
      bottom: TabBar(
          tabs: _tabs,
          isScrollable: true,
          physics: const BouncingScrollPhysics(),
          controller: _tabController),
      actions: [
        PopupMenuButton(
            color: Theme.of(context).dialogBackgroundColor,
            icon: Icon(Icons.more_vert_rounded,
                color: Theme.of(context).iconTheme.color),
            padding: EdgeInsets.all(10.0),
            offset: Offset.fromDirection(40, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            elevation: 0.0,
            onSelected: (value) {
              if (value == 'Search for transaction') {
              } else if (value == 'change display') {
              } else if (value == 'Adjust Balance') {
              } else if (value == 'Select time range') {}
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    value: 'Select time range',
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        SizedBox(width: 10.0),
                        Text('Select time range'.tr,
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    )),
                PopupMenuItem(
                    value: 'change display',
                    child: Row(
                      children: [
                        Icon(Icons.remove_red_eye,
                            color: Theme.of(context).iconTheme.color),
                        SizedBox(width: 10.0),
                        Text(true ? 'View by date'.tr : 'View by category'.tr,
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    )),
                PopupMenuItem(
                    value: 'Adjust Balance',
                    child: Row(
                      children: [
                        Icon(Icons.account_balance_wallet,
                            color: Theme.of(context).iconTheme.color),
                        SizedBox(width: 10.0),
                        Text('Adjust Balance'.tr,
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    )),
                PopupMenuItem(
                    value: 'Search for transaction',
                    child: Row(
                      children: [
                        Icon(Icons.search,
                            color: Theme.of(context).iconTheme.color),
                        SizedBox(width: 10.0),
                        Text('Search for transaction'.tr,
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    )),
              ];
            })
      ],
    );
  }

  @override
  Size get preferredSize => preferedSize;
}

void ShowWalletsModalBottomSheet(BuildContext context) {
  showMaterialModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40), topRight: Radius.circular(40)),
    ),
    builder: (context) => Container(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              'Select wallet'.tr,
              style: Theme.of(context).textTheme.headline5,
            ),
            WalletItem(),
            Divider(
              color: Theme.of(context).iconTheme.color,
            ),
            Container(
              height: 160,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return WalletItem();
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
      ),
    ),
  );
}
