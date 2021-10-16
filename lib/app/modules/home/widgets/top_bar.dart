import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keepital/app/core/values/app_strings.dart';
import 'package:keepital/app/core/values/asset_strings.dart';

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
      title: Row(
        children: [
          GestureDetector(
            onTap: () async {},
            child: Row(
              children: [
                SvgPicture.asset(AssetStringsPng.walletList, height: 30, width: 30,),
                Icon(Icons.arrow_drop_down)
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
                  style: TextStyle(fontSize: 11),
                ),
                Text('15.000.000')
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
            icon: Icon(Icons.more_vert_rounded),
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
              } else if (value == 'Select time range') {
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
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Select time range',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )),
                PopupMenuItem(
                    value: 'change display',
                    child: Row(
                      children: [
                        Icon(Icons.remove_red_eye),
                        SizedBox(width: 10.0),
                        Text(
                          true ? 'View by date' : 'View by category',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )),
                PopupMenuItem(
                    value: 'Adjust Balance',
                    child: Row(
                      children: [
                        Icon(Icons.account_balance_wallet),
                        SizedBox(width: 10.0),
                        Text(
                          'Adjust Balance',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )),
                PopupMenuItem(
                    value: 'Search for transaction',
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 10.0),
                        Text(
                          'Search for transaction',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
