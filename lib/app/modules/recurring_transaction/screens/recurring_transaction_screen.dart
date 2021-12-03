import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/global_widgets/default_loading.dart';
import 'package:keepital/app/modules/recurring_transaction/recurring_transaction_controller.dart';
import 'package:keepital/app/routes/pages.dart';

class RecurringTransactionScreen extends StatelessWidget {
  RecurringTransactionScreen({ Key? key }) : super(key: key);
  final _controller = Get.find<RecurringTransactionController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.textColor,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text("Recurring Transactions".tr),
            actions: <Widget>[],
            bottom: TabBar(
              tabs: [
                Text("on_going".tr),
                Text("finished".tr),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Get.toNamed(Routes.addRecurringTransaction);
            },
          ),
          body: TabBarView(
            children: [
              _controller.isLoading ? DefaultLoading() : Center(),
              _controller.isLoading ? DefaultLoading() : Center(),
            ],
          )),
    );
  }
}