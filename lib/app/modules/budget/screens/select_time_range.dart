import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/global_widgets/common_app_bar.dart';
import 'package:keepital/app/modules/budget/widgets/custom_time_range.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tuple/tuple.dart';

class SelectTimeRangeScreen extends StatefulWidget {
  @override
  _SelectTimeRangeScreenState createState() => _SelectTimeRangeScreenState();
}

class _SelectTimeRangeScreenState extends State<SelectTimeRangeScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    today = DateTime(today.year, today.month, today.day);
    return Scaffold(
      appBar: CommonAppBar(title: 'Select time range'.tr),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.all(4),
            child: buildTimeRangeListTile(title: 'This week'.tr, subTitle: '${today.firstDateOfWeek().dayInMonth} - ${today.lastDateOfWeek().dayInMonth}', mTimeRange: Tuple2(today.firstDateOfWeek(), today.lastDateOfWeek())),
          ),
          Container(
            padding: EdgeInsets.all(4),
            child: buildTimeRangeListTile(title: 'This month'.tr, subTitle: '${today.firstDateOfMonth().dayInMonth} - ${today.lastDateOfMonth().dayInMonth}', mTimeRange: Tuple2(today.firstDateOfMonth(), today.lastDateOfMonth())),
          ),
          Container(
            child: buildTimeRangeListTile(title: 'This quarter'.tr, subTitle: '${today.firstDateOfQuarter().dayInMonth} - ${today.lastDateOfQuarter().dayInMonth}', mTimeRange: Tuple2(today.firstDateOfQuarter(), today.lastDateOfQuarter())),
          ),
          Container(
            child: buildTimeRangeListTile(title: 'This year'.tr, subTitle: '01/01 - 31/12', mTimeRange: Tuple2(today.firstDateOfYear(), today.lastDateOfYear())),
          ),
          Container(
            padding: EdgeInsets.all(4),
            child: buildTimeRangeListTile(title: 'Next week'.tr, subTitle: '${today.firstDateOfNextWeek().dayInMonth} - ${today.lastDateOfNextWeek().dayInMonth}', mTimeRange: Tuple2(today.firstDateOfNextWeek(), today.lastDateOfNextWeek())),
          ),
          Container(
            padding: EdgeInsets.all(4),
            child: buildTimeRangeListTile(title: 'Next month'.tr, subTitle: '${today.firstDateOfNextMonth().dayInMonth} - ${today.lastDateOfNextMonth().dayInMonth}', mTimeRange: Tuple2(today.firstDateOfNextMonth(), today.lastDateOfNextMonth())),
          ),
          Container(
            child: buildTimeRangeListTile(title: 'Next quarter'.tr, subTitle: '${today.firstDateOfNextQuarter().dayInMonth} - ${today.lastDateOfNextQuarter().dayInMonth}', mTimeRange: Tuple2(today.firstDateOfNextQuarter(), today.lastDateOfNextQuarter())),
          ),
          Container(
            child: buildTimeRangeListTile(title: 'Next year'.tr, subTitle: '${today.firstDateOfNextYear().numbericDate} - ${today.lastDateOfNextYear().numbericDate}', mTimeRange: Tuple2(today.firstDateOfNextYear(), today.lastDateOfNextYear())),
          ),
          Container(
            child: buildTimeRangeListTile(title: 'Custom time range'.tr, subTitle: 'dd/MM/YYYY - dd/MM/YYYY', mCustom: true, mTimeRange: Tuple2(today.firstDateOfMonth(), today.lastDateOfMonth())),
          )
        ],
      ),
    );
  }

  Widget buildTimeRangeListTile({String title = "title", String subTitle = "sub tittle", bool mCustom = false, Tuple2<DateTime, DateTime>? mTimeRange}) {
    return Card(
      child: ListTile(
        onTap: mCustom
            ? () async {
                print('true');
                var result = await showCupertinoModalBottomSheet(isDismissible: true, context: context, builder: (context) => CustomTimeRange(beginDate: mTimeRange!.item1, endDate: mTimeRange!.item2));
                if (result != null) {
                  Get.back(result: result);
                }
              }
            : () {
                Get.back(result: mTimeRange);
              },
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          subTitle,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
