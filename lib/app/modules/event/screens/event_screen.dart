import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/modules/event/widgets/finished_tab.dart';
import 'package:keepital/app/modules/event/widgets/on_going_tab.dart';
import 'package:keepital/app/routes/pages.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventScreen createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen> {
  String dropdownValue = 'WalletOne';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text('event'.tr),
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
              Get.toNamed(Routes.addEvent);
            },
          ),
          body: TabBarView(
            children: [
              OnGoingTab(),
              FinishedTab(),
            ],
          )),
    );
  }
}
