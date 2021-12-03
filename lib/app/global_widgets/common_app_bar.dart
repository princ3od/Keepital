import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  CommonAppBar({Key? key, required this.title, this.onSaveTap})
      : size = Size.fromHeight(55),
        super(key: key);

  final Size size;
  final String title;
  final Function()? onSaveTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.grey[100],
      leading: IconButton(
        icon: Icon(
          Icons.close_sharp,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: () => Get.back(),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: [
        TextButton(
          onPressed: onSaveTap,
          child: Text('save'.tr),
          style: Theme.of(context).textButtonTheme.style,
        )
      ],
    );
  }

  @override
  Size get preferredSize => size;
}
