import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:dotted_line/dotted_line.dart';

class ClickableChipsInput extends StatelessWidget {
  const ClickableChipsInput({
    Key? key,
    this.leading,
    this.items,
    this.hintText = '',
    required this.onPressed,
    this.onDeleted,
    this.textSize = 12,
    this.enabled = true,
  }) : super(key: key);

  final Widget? leading;
  final List<String>? items;
  final String hintText;
  final Function() onPressed;
  final Function()? onDeleted;
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 24, bottom: 8),
                            child: isTextEmpty()
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      hintText,
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity), fontSize: textSize),
                                    ),
                                  )
                                : Wrap(
                                    spacing: 2,
                                    children: List.generate(items!.length, (index) {
                                      return Chip(label: Text(items![index]));
                                    }),
                                  )),
                        DottedLine(
                          dashColor: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity),
                          dashGapLength: enabled ? 0 : 8,
                          dashLength: 16,
                        )
                      ],
                    ),
                  ),
                  IconButton(onPressed: onDeleted, icon: Icon(Icons.delete))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isTextEmpty() {
    return items == null || items!.isEmpty;
  }
}
