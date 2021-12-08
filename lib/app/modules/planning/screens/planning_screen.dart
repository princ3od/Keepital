import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/modules/planning/widgets/planning_tile.dart';
import 'package:keepital/app/routes/pages.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Planning'.tr),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PlanningTile(
              iconData: FontAwesomeIcons.suitcase,
              title: "Budgets".tr,
              subtitle: "A financial plan to balance your income and expense".tr,
              action: () => {},
            ),
            PlanningTile(
              iconData: Icons.event,
              title: "Events".tr,
              subtitle: "Tracking on your spending during an actual event".tr,
              action: () {
                Get.toNamed(Routes.event);
              },
            ),
            PlanningTile(
              iconData: Icons.autorenew,
              title: "Recurring Transactions".tr,
              subtitle: "Transactions that are automatically added in future".tr,
              action: () => {Get.toNamed(Routes.recurringTransaction)},
            ),
            PlanningTile(
              iconData: Icons.receipt,
              title: "Recurring Payments".tr,
              subtitle: "Monitoring your repetitive bills".tr,
              action: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
