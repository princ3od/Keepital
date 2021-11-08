import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/utils/asset_utils.dart';
import 'package:keepital/app/core/utils/image_view.dart';
import 'package:keepital/app/core/values/app_colors.dart';

class IconSelectionScreen extends StatelessWidget {
  const IconSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List icons = [];
    AssetUtils.assets.forEach((key, value) => icons.add(value.path));
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.textColor),
          title: Text('Select Icon'.tr),
        ),
        body: GridView.builder(
          itemCount: icons.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          itemBuilder: (BuildContext context, int index) {
            return IconButton(
              onPressed: () {
                Get.back<String>(result: icons[index]);
              },
              icon: ImageView(icons[index], size: 42),
            );
          },
        ));
  }
}
