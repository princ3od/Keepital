import 'package:flutter/material.dart';
import 'package:keepital/app/core/utils/image_view.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/assets.gen.dart';

class TextfieldWithIconPicker extends StatelessWidget {
  TextfieldWithIconPicker({
    Key? key,
    required this.textEditingController,
    this.hintText = '',
    required this.onPressed,
    this.textSize = 16,
    this.iconId,
    this.iconSize,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String hintText;
  final String? iconId;
  final Function() onPressed;
  final double? textSize;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 8),
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: onPressed,
              child: Column(
                children: [
                  SizedBox(height: 13),
                  ImageView(
                    iconEmpty ? Assets.iconsUnknown.path : iconId!,
                    size: iconSize ?? 36,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                ],
              ),
            )),
        SizedBox(width: 8),
        Expanded(
          flex: 7,
          child: TextField(
            controller: textEditingController,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: textSize),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity - 0.1), fontSize: textSize),
            ),
          ),
        )
      ],
    );
  }

  bool get iconEmpty => iconId == null || iconId!.isEmpty;
}
