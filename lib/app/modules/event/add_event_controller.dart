import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/event.dart';
import 'package:keepital/app/data/providers/event_provider.dart';
import 'package:keepital/app/routes/pages.dart';

class AddEventController extends GetxController {
  var eventIcon = ''.obs;
  var endDate = DateTime.now().add(Duration(days: 30)).obs;
  var currencyName = ''.obs;
  TextEditingController eventNameController = TextEditingController();
  String currencyCode = '', currencySymbol = '';
  var isLoading = false.obs;

  void selectIcon(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    final result = await Get.toNamed(Routes.selectIcon);
    if (result != null) {
      eventIcon.value = result;
    }
  }

  void selectCurrency(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
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
    FocusScope.of(context).requestFocus(new FocusNode());
    var result = await showDatePicker(
      context: context,
      initialDate: endDate.value,
      firstDate: DateTime.now().add(Duration(days: 3)),
      lastDate: DateTime.now().add(Duration(days: 365 * 100)),
    );
    if (result != null) {
      endDate.value = result;
    }
  }

  Future<void> addEvent() async {
    if (isLoading.value) return;
    isLoading.value = true;
    Event event = Event(
      '',
      name: eventNameController.text,
      currencyId: currencyCode,
      currencySymbol: currencySymbol,
      isMarkedFinished: false,
      spending: 0,
      endDate: endDate.value,
    );
    await Future.delayed(AppValue.delayTime);
    await EventProvider().add(event);
    isLoading.value = false;
    Get.back(result: event);
  }
}
