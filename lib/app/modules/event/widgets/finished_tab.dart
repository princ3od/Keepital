import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinishedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Text('finished'),
        ],
      ),
    );
  }
}
