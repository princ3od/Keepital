import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AddCategoryTopBar extends StatelessWidget implements PreferredSizeWidget {
  AddCategoryTopBar({Key? key, this.onSaveTap})
      : size = Size.fromHeight(55),
        super(key: key);

  final Size size;
  final Function()? onSaveTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.grey[100],
      leading: IconButton(
        icon: Icon(
          Icons.close_sharp,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Add category'.tr,
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: [
        TextButton(onPressed: onSaveTap, child: Text('Save'.tr), style: Theme.of(context).textButtonTheme.style,)
      ],
    );
  }

  @override
  Size get preferredSize => size;
}
