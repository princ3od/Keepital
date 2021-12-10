import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailViewAppbar extends StatelessWidget implements PreferredSizeWidget {
  DetailViewAppbar({Key? key, this.onEditPressed, this.onDeletePressed, this.elevation})
      : _preferedSize = Size.fromHeight(50.0),
        super(key: key);

  final Size _preferedSize;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      leading: IconButton(
        splashRadius: 20.0,
        icon: Container(child: Icon(Icons.clear)),
        color: Theme.of(context).iconTheme.color,
        onPressed: () async {
          Get.back();
        },
      ),
      actions: [
        Visibility(
          visible: false,
          child: IconButton(
            splashRadius: 20.0,
            icon: Container(child: Icon(Icons.share)),
            color: Theme.of(context).iconTheme.color,
            onPressed: () async {
              Get.back();
            },
          ),
        ),
        IconButton(
          splashRadius: 20.0,
          icon: Container(child: Icon(Icons.edit)),
          color: Theme.of(context).iconTheme.color,
          onPressed: onEditPressed,
        ),
        IconButton(
          splashRadius: 20.0,
          icon: Container(child: Icon(Icons.delete)),
          color: Theme.of(context).iconTheme.color,
          onPressed: onDeletePressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => _preferedSize;
}
