import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/theme/app_theme.dart';
import 'package:keepital/app/core/values/assets.gen.dart';

class WalletCategoryItem extends StatefulWidget {
  final Function(String)? onPressed;
  final AssetGenImage genImage;
  final String title;

  const WalletCategoryItem({Key? key, this.onPressed, required this.genImage, required this.title}) : super(key: key);
  @override
  State<WalletCategoryItem> createState() => _WalletCategoryItemState();
}

class _WalletCategoryItemState extends State<WalletCategoryItem> {
  bool isCheked = false;
  _onCheck() async {
    setState(() {
      isCheked = true;
    });
    await Future.delayed(Duration(milliseconds: 500)).then((value) => {
          if (widget.onPressed != null)
            {
              widget.onPressed!(widget.genImage.path),
            },
          Get.back(),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: InkWell(
        onTap: _onCheck,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                widget.genImage.image(
                  width: 20,
                  height: 20,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  widget.title,
                  style: AppTheme.currentTheme.textTheme.headline6,
                ),
              ],
            ),
            Row(
              children: [
                Opacity(
                  opacity: isCheked ? 1 : 0,
                  child: Icon(
                    Icons.done_outlined,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
