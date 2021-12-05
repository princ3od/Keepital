import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/image_view.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/global_widgets/clickable_chips_input.dart';
import 'package:keepital/app/global_widgets/common_app_bar.dart';
import 'package:keepital/app/global_widgets/section_panel.dart';
import 'package:keepital/app/modules/add_transaction/add_transaction_controller.dart';
import 'package:keepital/app/global_widgets/clickable_list_item.dart';
import 'package:keepital/app/modules/add_transaction/widgets/icon_textfield.dart';
import 'package:keepital/app/modules/add_transaction/widgets/repeat_options_for%20_recurring_trans.dart';
import 'package:keepital/app/modules/home/widgets/wallet_item.dart';
import 'package:keepital/app/routes/pages.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddTransactionScreen extends StatelessWidget {
  final AddTransactionController _controller = Get.find<AddTransactionController>();
  final TransactionModel? trans;

  AddTransactionScreen({Key? key, this.trans}) {
    if (isEditing) {
      _controller.onLoadData(trans!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          title: getTitle,
          onSaveTap: () async {
            FocusScope.of(context).requestFocus(new FocusNode());
            if (isValidData()) {
              switch (Get.currentRoute) {
                case Routes.editTransaction:
                  await _controller.modifyTrans(trans!);
                  break;
                case Routes.addRecurringTransaction:
                  break;
                default:
                  await _controller.createNewTrans();
              }
            }
          }),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            SectionPanel(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                IconTextField(
                  textEditingController: _controller.amountTextController,
                  keyboardType: TextInputType.number,
                  hintText: 'Amount'.tr,
                ),
                Obx(() => ClickableListItem(
                      leading: ImageView(
                        _controller.categoryIconId.value,
                        size: 24,
                      ),
                      hintText: 'hint_category'.tr,
                      text: _controller.strCategory.value,
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        var category = await Get.toNamed(Routes.categories, arguments: true);

                        _controller.onSelectCategory(category);
                      },
                    )),
                IconTextField(
                  textEditingController: _controller.noteTextController,
                  hintText: 'hint_note'.tr,
                  icon: Image.asset(AssetStringsPng.note, color: Theme.of(context).iconTheme.color),
                ),
                Visibility(
                  visible: !isAddRecurringTrans,
                  child: Obx(() => ClickableListItem(
                        leading: Image.asset(AssetStringsPng.calendar, color: Theme.of(context).iconTheme.color),
                        text: _controller.strDate.value,
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _controller.date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100)) ?? DateTime.now();
                          _controller.strDate.value = _controller.date.fullDate;
                        },
                      )),
                ),
                Obx(() => ClickableListItem(
                      enabled: !isEditing,
                      leading: Icon(Icons.account_balance_wallet),
                      hintText: 'hint_wallet'.tr,
                      text: _controller.walletName.value,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        showWalletsModalBottomSheet(context);
                      },
                    )),
              ]),
            ),
            Visibility(
                visible: isAddRecurringTrans,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SectionPanel(
                      padding: EdgeInsets.all(0),
                      child: Obx(() => RepeatOptionsForRecurringTrans(
                            cycleLengthTextController: _controller.cycleLengthTextController,
                            numRepetitionsTextController: _controller.numRepetitionsTextController,
                            selectedOptsIndex: _controller.selectedOptsIndex.value,
                            selectedUnitIndex: _controller.selectedUnitIndex.value,
                            onUnitSelected: (index) {
                              _controller.selectedUnitIndex.value = index ?? 0;
                            },
                            onOptsSelected: (index) {
                              _controller.selectedOptsIndex.value = index ?? 0;
                            },
                            onFromDatePressed: () {

                            },
                            onToDatePressed: () {
                              
                            },
                          )),
                    ),
                  ],
                )),
            Visibility(visible: !isAddRecurringTrans, child: additionalInformation(context)),
            excludeFromReport(context),
            Visibility(visible: !isAddRecurringTrans, child: suggest(context))
          ],
        ),
      ),
    );
  }

  void showWalletsModalBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      builder: (context) => Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(children: [
            Column(
              children: [
                Text(
                  'Select wallet'.tr,
                  style: Theme.of(context).textTheme.headline5,
                ),
                LimitedBox(
                  maxHeight: 160,
                  child: ListView.builder(
                      itemExtent: 50.0,
                      shrinkWrap: true,
                      itemCount: _controller.wallets.length,
                      itemBuilder: (BuildContext context, int index) {
                        String key = _controller.wallets.keys.elementAt(index);
                        return Obx(() => WalletItem(
                              wallet: _controller.wallets[key]!,
                              selectedId: _controller.walletId.value,
                              onTap: () {
                                _controller.walletId.value = key;
                                _controller.walletName.value = _controller.wallets[key]!.name;
                              },
                            ));
                      }),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget additionalInformation(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.width * 0.05),
        SectionPanel(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              ClickableListItem(
                onPressed: () {},
                leading: Image.asset(AssetStringsPng.calendar),
                hintText: 'hint_event'.tr,
              ),
              Obx(() => ClickableChipsInput(
                    onPressed: () async {
                      var x = await Get.toNamed(Routes.addChipsScreen, arguments: listToString(_controller.peoples.value));

                      if (x != null) {
                        _controller.peoples.value = x.split(',');
                      }
                    },
                    onDeleted: () {
                      _controller.peoples.update((val) {
                        val?.clear();
                      });
                    },
                    leading: Icon(
                      Icons.people,
                      size: 25.0,
                    ),
                    items: _controller.peoples.value,
                    hintText: 'hint_with'.tr,
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget excludeFromReport(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.width * 0.05),
        SectionPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: AppColors.primaryColor,
                      value: _controller.excludeFromReport.value,
                      onChanged: (value) {
                        _controller.excludeFromReport.value = value!;
                      },
                    )
                  ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('exclude_label'.tr, style: Theme.of(context).textTheme.bodyText1),
                      Text(
                        'exclude_description'.tr,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Color.fromARGB(127, 0, 0, 0)),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget suggest(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.width * 0.05),
        Container(margin: EdgeInsets.only(left: 25), child: Text('suggest_label'.tr, style: Theme.of(context).textTheme.bodyText2)),
        Container(
            margin: EdgeInsets.only(left: 25),
            child: Text(
              'suggest_description'.tr,
              style: Theme.of(context).textTheme.subtitle1,
            ))
      ],
    );
  }

  String get getTitle {
    if (isEditing) return 'edit_transaction'.tr;
    if (isAddRecurringTrans) return 'add_recurring_transaction'.tr;
    return 'add_transaction'.tr;
  }

  bool isValidData() {
    if (_controller.amountTextController.text.isBlank!) {
      Get.snackbar('', '', titleText: Text('Info'.tr), messageText: Text('Please fill out the amount field'.tr));
      return false;
    } else if (_controller.strCategory.value == '') {
      Get.snackbar('', '', titleText: Text('Info'.tr), messageText: Text('Please fill out the category field'.tr));
      return false;
    } else if (_controller.walletId.value == '') {
      Get.snackbar('', '', titleText: Text('Info'.tr), messageText: Text('Please fill out the wallet field'.tr));
      return false;
    }
    return true;
  }

  bool get isEditing => trans != null;
  bool get isAddRecurringTrans => Get.currentRoute == Routes.addRecurringTransaction;
}
