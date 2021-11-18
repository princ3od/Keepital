import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/models/event.dart';
import 'package:keepital/app/modules/event/event_controller.dart';
import 'package:keepital/app/modules/event/widgets/event_item.dart';

class FinishedTab extends StatelessWidget {
  final List<Event> events;
  final _controller = Get.find<EventController>();
  FinishedTab({Key? key, required this.events}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: events.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index) {
          return EventItem(
            event: events[index],
            onEdit: () => _controller.onEditEvent(events[index]),
            onDelete: () => _controller.onDeleteEvent(events[index]),
          );
        },
      ),
    );
  }
}
