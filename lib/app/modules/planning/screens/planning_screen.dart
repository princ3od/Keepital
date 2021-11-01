import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/theme/app_theme.dart';
import 'package:keepital/app/modules/planning/widgets/planning_panel.dart';
import 'package:keepital/app/modules/planning/widgets/planning_tile.dart';
import 'package:keepital/app/routes/pages.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.currentTheme.backgroundColor,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                PlanningPanel(
                    txtTitle: "Planning".tr,
                    action: () => {},
                    icon: Icon(Icons.arrow_drop_down)),
                PlanningTile(
                  iconData: Icons.work,
                  title: "Budgets".tr,
                  subtitle:
                      "A financial plan to balance your income and expense".tr,
                  action: () => {},
                ),
                PlanningTile(
                  iconData: Icons.event,
                  title: "Events".tr,
                  subtitle:
                      "Tracking on your spending during an actual event".tr,
                  action: () {
                    Get.toNamed(Routes.event);
                  },
                ),
                PlanningTile(
                  iconData: Icons.autorenew,
                  title: "Recurring Transactions".tr,
                  subtitle:
                      "Transactions that are automatically added in future".tr,
                  action: () => {},
                ),
                PlanningTile(
                  iconData: Icons.receipt,
                  title: "Recurring Payments".tr,
                  subtitle: "Monitoring your repetitive bills".tr,
                  action: () => {},
                ),
                Spacer(flex: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
