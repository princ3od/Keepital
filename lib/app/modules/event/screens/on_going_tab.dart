import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepital/app/modules/event/widgets/event_list_item.dart';

class OnGoingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child:  Icon(Icons.add),
        onPressed: () {
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          EventListItemCard(),
          EventListItemCard(),
        ],
      ),
    );
  }
}
