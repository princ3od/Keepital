import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/modules/home/home_controller.dart';
import 'package:keepital/app/modules/home/widgets/wallet_item.dart';
import 'package:keepital/app/routes/pages.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  TopBar({Key? key, required TabController tabController, required List<Text> tabs})
      : preferedSize = Size.fromHeight(100),
        _tabController = tabController,
        _tabs = tabs,
        super(key: key);

  final Size preferedSize;
  final TabController _tabController;
  final List<Text> _tabs;

  final HomeController _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      title: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              showWalletsModalBottomSheet(context);
            },
            child: Row(
              children: [
                Container(
                    child: Image(
                  image: AssetImage(AssetStringsPng.walletList),
                  height: 30,
                )),
                Icon(Icons.arrow_drop_down, color: Theme.of(context).iconTheme.color)
              ],
            ),
          ),
          Obx(() => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _controller.curWalletName.value,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(_controller.curWalletAmount.value, style: Theme.of(context).textTheme.headline4)
                  ],
                ),
              ))
        ],
      ),
      bottom: TabBar(tabs: _tabs, isScrollable: true, physics: const BouncingScrollPhysics(), controller: _tabController),
      actions: [
        PopupMenuButton(
            color: Theme.of(context).dialogBackgroundColor,
            icon: Icon(Icons.more_vert_rounded, color: Theme.of(context).iconTheme.color),
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
                Get.toNamed(Routes.walletBalance);
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
                        Text('Select time range'.tr, style: Theme.of(context).textTheme.bodyText1)
                      ],
                    )),
                PopupMenuItem(
                    value: 'change display',
                    child: Row(
                      children: [Icon(Icons.remove_red_eye, color: Theme.of(context).iconTheme.color), SizedBox(width: 10.0), Text(true ? 'View by date'.tr : 'View by category'.tr, style: Theme.of(context).textTheme.bodyText1)],
                    )),
                PopupMenuItem(
                    value: 'Adjust Balance',
                    child: Row(
                      children: [Icon(Icons.account_balance_wallet, color: Theme.of(context).iconTheme.color), SizedBox(width: 10.0), Text('Adjust Balance'.tr, style: Theme.of(context).textTheme.bodyText1)],
                    )),
                PopupMenuItem(
                    value: 'Search for transaction',
                    child: Row(
                      children: [Icon(Icons.search, color: Theme.of(context).iconTheme.color), SizedBox(width: 10.0), Text('Search for transaction'.tr, style: Theme.of(context).textTheme.bodyText1)],
                    )),
              ];
            })
      ],
    );
  }

  @override
  Size get preferredSize => preferedSize;

  void showWalletsModalBottomSheet(BuildContext context) {
    Wallet total = Wallet('', name: 'Total'.tr, amount: _controller.currentUser!.amount, currencyId: '', iconId: '');

    showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      builder: (context) => Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(children: [
            Column(
              children: [
                Text(
                  'Select wallet'.tr,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Obx(
                  () => WalletItem(
                      wallet: total,
                      selectedId: _controller.currentWallet.value,
                      onTap: () {
                        _controller.currentWallet.value = '';
                        _controller.curWalletName.value = 'Total';
                        _controller.curWalletAmount.value = _controller.currentUser?.amount.toString() ?? '';
                      }),
                ),
                Divider(
                  color: Theme.of(context).iconTheme.color,
                ),
                LimitedBox(
                  maxHeight: 160,
                  child: ListView.builder(
                      itemExtent: 50.0,
                      shrinkWrap: true,
                      itemCount: _controller.wallets.length,
                      itemBuilder: (BuildContext context, int index) {
                        String key = _controller.wallets.keys.elementAt(index);
                        return Obx(() => WalletItem(
                              wallet: _controller.wallets[key]!,
                              selectedId: _controller.currentWallet.value,
                              onTap: () {
                                _controller.currentWallet.value = _controller.wallets[key]?.id ?? '';
                                _controller.curWalletName.value = _controller.wallets[_controller.currentWallet]?.name ?? 'Total';
                                _controller.curWalletAmount.value = _controller.wallets[_controller.currentWallet]?.amount.toString() ?? _controller.currentUser?.amount.toString() ?? '';
                              },
                            ));
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
      ),
    );
  }
}
