import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:keepital/app/global_widgets/common_app_bar.dart';
import 'package:tuple/tuple.dart';

class CustomTimeRange extends StatefulWidget {
  final beginDate;
  final endDate;

  CustomTimeRange({Key? key, @required this.beginDate, @required this.endDate}) : super(key: key);
  @override
  CustomTimeRangeState createState() => CustomTimeRangeState();
}

class CustomTimeRangeState extends State<CustomTimeRange> {
  DateTime? realBeginDate;
  DateTime? realEndDate;

  @override
  void initState() {
    super.initState();
    realBeginDate = widget.beginDate;
    realEndDate = widget.endDate;
  }

  @override
  Widget build(BuildContext context) {
    String beginDate = realBeginDate != null ? DateFormat('dd/MM/yyyy').format(realBeginDate!) : 'Choose begin date';

    String endDate = realEndDate != null ? DateFormat('dd/MM/yyyy').format(realEndDate!) : 'Choose end date';

    return Scaffold(
        appBar: CommonAppBar(
          title: 'Choose time range'.tr,
          onSaveTap: () {
            Get.back(result: Tuple2(realBeginDate, realEndDate));
          },
        ),
        body: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: ListTile(
                    onTap: () async {
                      var result = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2200));
                      if (result != null) {
                        setState(() {
                          realBeginDate = result;
                        });
                      }
                    },
                    title: Text(
                      'Begin date'.tr,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      beginDate,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () async {
                      var result = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2200));
                      if (result != null) {
                        setState(() {
                          realEndDate = result;
                        });
                      }
                    },
                    title: Text(
                      'End date'.tr,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      endDate,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
