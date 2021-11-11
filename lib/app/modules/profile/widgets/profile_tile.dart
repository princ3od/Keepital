import 'package:flutter/material.dart';
import 'package:keepital/app/core/values/app_colors.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final Function()? action;
  final IconData? iconData;
  final Color? textColor;
  final bool isShownTrailingIcon;

  ProfileTile({required this.title, this.action, this.iconData, this.textColor, this.isShownTrailingIcon = true});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: ListTile(
          leading: iconData != null
              ? Icon(
                  iconData,
                  size: 22,
                  color: textColor ?? AppColors.textColor.withOpacity(0.5),
                )
              : null,
          trailing: (isShownTrailingIcon)
              ? Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: textColor ?? AppColors.textColor,
                )
              : null,
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1!.apply(color: textColor ?? AppColors.textColor),
          ),
        ),
      ),
    );
  }
}
