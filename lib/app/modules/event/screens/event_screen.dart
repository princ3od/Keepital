import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/global_widgets/default_loading.dart';
import 'package:keepital/app/modules/event/event_controller.dart';
import 'package:keepital/app/modules/event/widgets/finished_tab.dart';
import 'package:keepital/app/modules/event/widgets/on_going_tab.dart';

class EventScreen extends StatelessWidget {
  final _controller = Get.find<EventController>();
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
            onPressed: () => _controller.onAddEvent(),
          ),
          body: TabBarView(
            children: [
              Obx(() => _controller.isLoading.value ? DefaultLoading() : OnGoingTab(events: _controller.onGoingEvents.value)),
              Obx(() => _controller.isLoading.value ? DefaultLoading() : FinishedTab(events: _controller.finishedEvents.value)),
            ],
          )),
    );
  }
}
