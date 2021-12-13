import 'package:flutter/material.dart';
import 'package:keepital/app/core/values/app_colors.dart';

class IconTextField extends StatelessWidget {
  IconTextField({Key? key, required this.textEditingController, this.hintText = '', this.textSize = 12, this.icon, this.keyboardType}) : super(key: key);

  final TextEditingController textEditingController;
  final String hintText;
  final Widget? icon;
  final double? textSize;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 8),
        Expanded(
            flex: 1,
            child: icon ??
                SizedBox(
                  width: 36,
                )),
        SizedBox(width: 8),
        Expanded(
          flex: 7,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: keyboardType,
                  controller: textEditingController,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: textSize),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity - 0.1), fontSize: textSize),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              )
            ],
          ),
        )
      ],
    );
  }
}
