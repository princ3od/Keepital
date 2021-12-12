import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/utils/image_view.dart';

class WalletIconPicker extends StatelessWidget {
  WalletIconPicker({Key? key, required this.onTap, required this.iconPath}) : super(key: key);
  final VoidCallback onTap;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ImageView(iconPath, size: 48),
                const SizedBox(height: 8),
                Text(
                  "CHANGE ICON".tr,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
