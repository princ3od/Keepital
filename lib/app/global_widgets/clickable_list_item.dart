import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:dotted_line/dotted_line.dart';

class ClickableListItem extends StatelessWidget {
  const ClickableListItem({
    Key? key,
    this.leading,
    this.text,
    this.hintText = '',
    required this.onPressed,
    this.textSize = 12,
    this.enabled = true,
  }) : super(key: key);

  final Widget? leading;
  final String? text;
  final String hintText;
  final Function() onPressed;
  final double? textSize;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onPressed : null,
      child: Row(
        children: [
          SizedBox(width: 8),
          Expanded(flex: 1, child: Opacity(opacity: enabled ? 0.7 : 0.5, child: Center(child: leading))),
          SizedBox(width: 8),
          Expanded(
            flex: 7,
            child: Opacity(
              opacity: enabled ? 1 : 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 8),
                    child: Text(
                      isTextEmpty() ? hintText : text!,
                      style: isTextEmpty()
                          ? Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity), fontSize: textSize)
                          : Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: textSize),
                    ),
                  ),
                  const SizedBox(height: 8),
                  DottedLine(
                    dashColor: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity),
                    dashGapLength: enabled ? 0 : 8,
                    dashLength: 16,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  bool isTextEmpty() {
    return text == null || text!.isEmpty;
  }
}
