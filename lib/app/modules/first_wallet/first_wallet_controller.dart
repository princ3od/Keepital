import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_strings.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:currency_picker/currency_picker.dart';

class FirstWalletScreenController extends GetxController {
  void showCurrencyPickerOfWalletScreen(BuildContext context) {
    return showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        print('Select currency: ${currency.name}');
      },
    );
  }
}
