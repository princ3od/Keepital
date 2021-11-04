import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final String? title;
  final Function()? action;
  final IconData? iconData;

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
