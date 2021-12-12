import 'package:flutter/material.dart';
import 'package:keepital/app/core/values/app_colors.dart';

class PlanningTile extends StatelessWidget {
  final IconData iconData;
  final String? title;
  final String? subtitle;
  final Function()? action;

  PlanningTile({required this.iconData, this.title, this.subtitle, this.action});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 8,
      contentPadding: const EdgeInsets.only(left: 20, right: 20),
      onTap: action,
      leading: Icon(iconData, size: 28, color: AppColors.textColor),
      title: Text(title ?? "", style: Theme.of(context).textTheme.headline4),
      subtitle: Text(subtitle ?? "", style: Theme.of(context).textTheme.subtitle1),
      trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity)),
    );
  }
}
