import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:keepital/app/routes/pages.dart';

class FinishedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child:  Icon(Icons.add),
        onPressed: () {
          Get.toNamed(Routes.addEvent);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Text('finished'),
        ],
      ),
    );
  }
}
