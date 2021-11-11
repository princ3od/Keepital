import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClickableListItem extends StatelessWidget {
  const ClickableListItem({Key? key, required this.icon, this.text, this.hintText = '', required this.onPressed}) : super(key: key);

  final Widget icon;
  final String? text;
  final String hintText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        height: 60,
        child: InkWell(
          onTap: onPressed,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: icon,
                  height: 30,
                ),
              ),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 2),
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
        )
      );
  }

  bool isTextEmpty() {
    return text == null || text!.isEmpty;
  }
}
