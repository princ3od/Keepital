import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepital/app/data/models/event.dart';
import 'package:keepital/app/modules/event/widgets/event_item.dart';

import 'on_going_tab.dart';

class FinishedTab extends StatelessWidget {
  final List<Event>? events;
  FinishedTab({Key? key, this.events}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: events?.length ?? FakeData.events.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index) {
          return EventItem(event: events?[index] ?? FakeData.events[index]);
        },
      ),
    );
  }
}
