import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepital/app/data/models/event.dart';
import 'package:keepital/app/modules/event/widgets/event_item.dart';

class FakeData {
  static final List<Event> events = [
    Event('1', name: 'Main', currencyId: 'VND', spending: 12312, isMarkedCompleted: true, endDate: DateTime(2020, 9, 7), currencySymbol: ''),
    Event('2', name: 'Secondary', currencyId: 'USD', spending: 99990, isMarkedCompleted: false, endDate: DateTime(2021, 9, 7), currencySymbol: '')
  ];
}

class OnGoingTab extends StatelessWidget {
  final items = List.from(FakeData.events);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index) {
          return EventItem(event: items[index]);
        },
      ),
    );
  }
}
