
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:keepital/app/data/models/event.dart';
import 'package:keepital/app/modules/event/widgets/event_list_item.dart';
import 'package:keepital/app/routes/pages.dart';


class FakeData  {
  static final List<Event> events =[
    Event('1', name: 'Main', currency: 'VND', spending: 12312, isCompleted: false, date: DateTime(2020,9,7)),
    Event('2', name: 'Secondary', currency: 'USD', spending: 99990, isCompleted: false, date: DateTime(2021,9,7))
  ];
}
class OnGoingTab extends StatefulWidget{
  @override
  _OnGoingTab createState() => _OnGoingTab();

}
class _OnGoingTab extends State<OnGoingTab> {
  final items = List.from(FakeData.events);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child:  Icon(Icons.add),
        onPressed: () {
          Get.toNamed(Routes.addEvent);
        },
      ),
      body: ListView.builder(
        itemCount:items.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index){
          return EventListItemCard(item: items[index]);
        },
      ),
    );
  }
}
