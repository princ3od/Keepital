import 'package:flutter/material.dart';

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
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          height: 34,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (iconData == null) ? Icon(Icons.ac_unit_outlined) : Icon(iconData),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(height: 10, child: Text(title ?? "", style: Theme.of(context).textTheme.subtitle1)),
                ],
              ),
              Icon(Icons.keyboard_arrow_right),
            ],
          )),
    );
  }
}
