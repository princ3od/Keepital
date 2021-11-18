import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
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
  String? eventToEidtId;
  AddEventController(Event? event) {
    if (event != null) {
      eventToEidtId = event.id;
      eventNameController.text = event.name;
      endDate.value = event.endDate!;
      currencyName.value = event.currencyName;
      currencyCode = event.currencyId;
      currencySymbol = event.currencySymbol;
      eventIcon.value = event.iconId;
    }
  }
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

  Future<void> save(BuildContext context) async {
    if (Get.isDialogOpen!) {
      return;
    }
    FocusScope.of(context).requestFocus(new FocusNode());
    Utils.showLoadingDialog();
    Event event = Event(
      eventToEidtId ?? '',
      name: eventNameController.text,
      currencyId: currencyCode,
      currencySymbol: currencySymbol,
      currencyName: currencyName.value,
      isMarkedFinished: false,
      spending: 0,
      endDate: endDate.value,
    );
    await Future.delayed(AppValue.delayTime);
    if (eventToEidtId != null) {
      await EventProvider().update(event.id!, event);
    } else {
      await EventProvider().add(event);
    }
    Utils.hideLoadingDialog();
    Get.back(result: event);
  }
}
