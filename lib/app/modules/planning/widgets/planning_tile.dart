import 'package:flutter/material.dart';

class PlanningTile extends StatelessWidget {
  final IconData iconData;
  final String? title;
  final String? subtitle;
  final Function()? action;

  PlanningTile(
      {required this.iconData, this.title, this.subtitle, this.action});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        child: ListTile(
          horizontalTitleGap: 0,
          minVerticalPadding: 0,
          onTap: action,
          leading: Icon(
            iconData,
            size: 30,
          ),
          title: Text(title ?? "",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
          subtitle: Text(subtitle ?? "",
              style: Theme.of(context).textTheme.subtitle1),
          trailing: Icon(Icons.keyboard_arrow_right),
        ));
  }
}
