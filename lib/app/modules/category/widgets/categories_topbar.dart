import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/modules/category/categories_controller.dart';

class CategoriesTopBar extends StatelessWidget implements PreferredSizeWidget {
  CategoriesTopBar({Key? key})
      : preferedSize = Size.fromHeight(100),
        super(key: key);

  final Size preferedSize;
  final CategoriesController _controller = Get.find<CategoriesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => AppBar(
          elevation: 2,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Categories'.tr,
            style: Theme.of(context).textTheme.headline6,
          ),
          bottom: TabBar(tabs: _controller.tabs, isScrollable: true, physics: const BouncingScrollPhysics(), controller: _controller.tabController.value),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        ));
  }

  @override
  Size get preferredSize => preferedSize;
}
