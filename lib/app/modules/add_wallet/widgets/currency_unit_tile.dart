import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/theme/app_theme.dart';

class CurrencyUnitTile extends StatelessWidget {
  final VoidCallback onPressed;
  final TextEditingController textEditingController;
  final String currencyPickedSymbol;
  const CurrencyUnitTile({Key? key, required this.onPressed, required this.textEditingController, required this.currencyPickedSymbol}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        children: [
          SizedBox(
            width: 23,
          ),
          Center(
            child: (currencyPickedSymbol == "")
                ? Icon(Icons.money)
                : SizedBox(
                    width: 24,
                    child: Text(
                      currencyPickedSymbol,
                      style: AppTheme.currentTheme.textTheme.headline2,
                    ),
                  ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: TextField(
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.left,
              enabled: true,
              showCursor: false,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Currency'.tr,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              ),
              onTap: () => onPressed(),
              controller: textEditingController,
            ),
          ),
        ],
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
