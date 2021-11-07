import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/home/home_controller.dart';
import 'package:keepital/app/modules/home/widgets/wallet_item.dart';
import 'package:keepital/app/routes/pages.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  TopBar({Key? key, required this.selectTimeRangeCallBack, required this.selectWalletCallBack})
      : preferedSize = Size.fromHeight(100),
        super(key: key);

  final Size preferedSize;

  final HomeController _controller = Get.find<HomeController>();
  final Function(TimeRange) selectTimeRangeCallBack;
  final Function() selectWalletCallBack;

  @override
  Widget build(BuildContext context) {
    return Obx(() => AppBar(
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
                      child: _controller.curWalletIcon.value.isEmpty
                          ? Image(
                              image: AssetImage(AssetStringsPng.walletList),
                              height: 30,
                            )
                          : Image.asset(
                              "${_controller.curWalletIcon.value}",
                              height: 30,
                            ),
                    ),
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
          bottom: TabBar(tabs: _controller.tabs, isScrollable: true, physics: const BouncingScrollPhysics(), controller: _controller.tabController.value),
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
                onSelected: (value) {
                  if (value == 'Search for transaction') {
                  } else if (value == 'change display') {
                  } else if (value == 'Adjust Balance') {
                    Get.toNamed(Routes.walletBalance);
                  } else if (value == 'Select time range') {
                    handleSelectTimeRange(context);
                  }
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
        ));
  }

  @override
  Size get preferredSize => preferedSize;

  void showWalletsModalBottomSheet(BuildContext context) {
    Wallet total = Wallet('', name: 'Total'.tr, amount: _controller.currentUser!.amount, currencyId: '', iconId: '', currencySymbol: 'None_set');

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
                        _controller.onCurrentWalletChange('');
                        selectWalletCallBack();
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
                                _controller.onCurrentWalletChange(key);
                                selectWalletCallBack();
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

  void handleSelectTimeRange(BuildContext context) {
    showMenu(
      color: Theme.of(context).dialogBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      context: context,
      position: RelativeRect.fromLTRB(100, 55, 28, 0),
      items: [
        CheckedPopupMenuItem(
          checked: _controller.selectedTimeRange.value == TimeRange.day,
          value: TimeRange.day,
          child: Text("Day".tr, style: Theme.of(context).textTheme.bodyText1),
        ),
        CheckedPopupMenuItem(
          checked: _controller.selectedTimeRange.value == TimeRange.week,
          value: TimeRange.week,
          child: Text("Week".tr, style: Theme.of(context).textTheme.bodyText1),
        ),
        CheckedPopupMenuItem(
          checked: _controller.selectedTimeRange.value == TimeRange.month,
          value: TimeRange.month,
          child: Text("Month".tr, style: Theme.of(context).textTheme.bodyText1),
        ),
        CheckedPopupMenuItem(
          checked: _controller.selectedTimeRange.value == TimeRange.quarter,
          value: TimeRange.quarter,
          child: Text("Quarter".tr, style: Theme.of(context).textTheme.bodyText1),
        ),
        CheckedPopupMenuItem(
          checked: _controller.selectedTimeRange.value == TimeRange.year,
          value: TimeRange.year,
          child: Text("Year".tr, style: Theme.of(context).textTheme.bodyText1),
        ),
        CheckedPopupMenuItem(
          checked: _controller.selectedTimeRange.value == TimeRange.all,
          value: TimeRange.all,
          child: Text("All".tr, style: Theme.of(context).textTheme.bodyText1),
        ),
      ],
    ).then((value) async {
      switch (value) {
        case TimeRange.day:
          _controller.selectedTimeRange.value = TimeRange.day;
          _controller.tabs.value = _controller.initTabBar(TimeRange.day);
          selectTimeRangeCallBack(TimeRange.day);
          break;
        case TimeRange.week:
          _controller.selectedTimeRange.value = TimeRange.week;
          _controller.tabs.value = _controller.initTabBar(TimeRange.week);
          selectTimeRangeCallBack(TimeRange.week);
          break;
        case TimeRange.month:
          _controller.selectedTimeRange.value = TimeRange.month;
          _controller.tabs.value = _controller.initTabBar(TimeRange.month);
          selectTimeRangeCallBack(TimeRange.month);
          break;
        case TimeRange.quarter:
          _controller.selectedTimeRange.value = TimeRange.quarter;
          _controller.tabs.value = _controller.initTabBar(TimeRange.quarter);
          selectTimeRangeCallBack(TimeRange.quarter);
          break;
        case TimeRange.year:
          _controller.selectedTimeRange.value = TimeRange.year;
          _controller.tabs.value = _controller.initTabBar(TimeRange.year);
          selectTimeRangeCallBack(TimeRange.year);
          break;
        case TimeRange.all:
          _controller.selectedTimeRange.value = TimeRange.all;
          _controller.tabs.value = _controller.initTabBar(TimeRange.all);
          selectTimeRangeCallBack(TimeRange.all);
          break;
        default:
          break;
      }
    });
  }
}
