import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/theme/app_theme.dart';

class ProfileTile extends StatelessWidget {
  String? title;
  Function()? action;
  IconData? iconData;

  ProfileTile({this.title, this.action, this.iconData});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
          width: 350,
          height: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      (iconData == null)
                          ? Icon(Icons.ac_unit_outlined)
                          : Icon(iconData),
                      SizedBox(
                        width: 5,
                      ),
                      Text(title ?? "",
                          style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ],
          )),
    );

  }
}
