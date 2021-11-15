import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keepital/app/core/values/app_colors.dart';

class ClickableListItem extends StatelessWidget {
  const ClickableListItem({
    Key? key,
    this.leading,
    this.text,
    this.hintText = '',
    required this.onPressed,
    this.textSize = 12,
  }) : super(key: key);

  final Widget? leading;
  final String? text;
  final String hintText;
  final Function() onPressed;
  final double? textSize;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          SizedBox(width: 8),
          Expanded(flex: 1, child: Center(child: leading)),
          SizedBox(width: 8),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 22, bottom: 6),
                  child: Text(
                    isTextEmpty() ? hintText : text!,
                    style: isTextEmpty()
                        ? Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity - 0.15), fontSize: textSize)
                        : Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: textSize),
                  ),
                ),
                Divider(
                  color: AppColors.textColor,
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  bool isTextEmpty() {
    return text == null || text!.isEmpty;
  }
}
