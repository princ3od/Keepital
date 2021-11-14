import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClickableListItem extends StatelessWidget {
  const ClickableListItem({
    Key? key,
    required this.leading,
    this.text,
    this.hintText = '',
    required this.onPressed,
    this.textStyle,
  }) : super(key: key);

  final Widget leading;
  final String? text;
  final String hintText;
  final Function() onPressed;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16),
        child: InkWell(
          onTap: onPressed,
          child: Row(
            children: [
              leading,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 22, bottom: 6),
                        child: Text(
                          isTextEmpty() ? hintText : text!,
                          style: isTextEmpty() ? Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey[350]) : Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      )
                    ],
                  ),
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
