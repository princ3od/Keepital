import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/event.dart';
import 'package:keepital/app/data/providers/event_provider.dart';

class AddEventController extends GetxController {
  var eventIcon = ''.obs;
  var endDate = DateTime.now().add(Duration(days: 30)).obs;
  var currencyName = ''.obs;
  TextEditingController eventNameController = TextEditingController();
  String currencyCode = '', currencySymbol = '';

  void pickCurrency(BuildContext context) {
    return showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        currencyCode = currency.code;
        currencySymbol = currency.symbol;
        currencyName.value = '${currency.name} ($currencyCode)';
      },
      favorite: AppValue.favoritedCurrencies,
    );
  }

  Future<void> selectEndDate(BuildContext context) async {
    var result = await showDatePicker(
      context: context,
      initialDate: endDate.value,
      firstDate: DateTime.now().add(Duration(days: 3)),
      lastDate: DateTime.now().add(Duration(days: 365 * 100)),
    );
    FocusScope.of(context).requestFocus(new FocusNode());
    if (result != null) {
      endDate.value = result;
    }
  }

  Future<void> addEvent(BuildContext context) async {
    Event event = Event(
      '',
      name: eventNameController.text,
      currencyId: currencyCode,
      currencySymbol: currencySymbol,
      isMarkedCompleted: false,
      spending: 0,
      endDate: endDate.value,
    );
    await EventProvider().add(event);
  }
}
