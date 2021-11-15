import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/global_widgets/section_panel.dart';
import 'package:keepital/app/modules/add_transaction/add_transaction_controller.dart';
import 'package:keepital/app/global_widgets/clickable_list_item.dart';
import 'package:keepital/app/modules/home/widgets/wallet_item.dart';
import 'package:keepital/app/routes/pages.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddTransactionScreen extends StatelessWidget {
  final AddTransactionController _controller = Get.find<AddTransactionController>();
  final amountTextController = TextEditingController();
  final noteTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('yyyy-MM-dd');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[100],
        leading: IconButton(
          icon: Icon(
            Icons.close_sharp,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'add_transaction'.tr,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(primary: AppColors.primaryColor, textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
            onPressed: () async {
              if (isValidData()) {
                await _controller.createNewTrans(num.tryParse(amountTextController.text)!, noteTextController.text);
                Navigator.pop(context);
              }
            },
            child: Text("save".tr),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            SectionPanel(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: TextField(
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        controller: amountTextController,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
                Obx(() => ClickableListItem(
                      leading: ImageIcon(AssetImage(AssetStringsPng.unknownCategory)),
                      hintText: 'hint_category'.tr,
                      text: _controller.strCategory.value,
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        var category = await Get.toNamed(Routes.categories, arguments: true);

                        _controller.onSelectCategory(category);
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: Image.asset(AssetStringsPng.note),
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Flexible(
                        flex: 5,
                        child: TextFormField(
                          autofocus: false,
                          controller: noteTextController,
                          decoration: InputDecoration(hintText: 'hint_note'.tr, hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey[350])),
                        ))
                  ],
                ),
                Obx(() => ClickableListItem(
                      leading: Image.asset(AssetStringsPng.calendar),
                      text: _controller.strDate.value,
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _controller.date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100)) ?? DateTime.now();
                        _controller.strDate.value = formatter.format(_controller.date);
                      },
                    )),
                Obx(() => ClickableListItem(
                      leading: Icon(Icons.account_balance_wallet),
                      hintText: 'hint_wallet'.tr,
                      text: _controller.curWalletName.value,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        showWalletsModalBottomSheet(context);
                      },
                    )),
              ]),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            SectionPanel(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Image.asset(AssetStringsPng.calendar),
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Flexible(
                          flex: 5,
                          child: TextFormField(
                            decoration: InputDecoration(hintText: 'hint_event'.tr, hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey[350])),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Icon(
                          Icons.people,
                          size: 25.0,
                        ),
                      ),
                      Flexible(
                          flex: 5,
                          child: TextFormField(
                            decoration: InputDecoration(hintText: 'hint_with'.tr, hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey[350])),
                          ))
                    ],
                  ),
                ],
              ),
            ),
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
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            Container(margin: EdgeInsets.only(left: 50), child: Text('suggest_label'.tr, style: Theme.of(context).textTheme.bodyText2)),
            Container(
                margin: EdgeInsets.only(left: 50),
                child: Text(
                  'suggest_description'.tr,
                  style: Theme.of(context).textTheme.subtitle1,
                ))
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
                              selectedId: _controller.currentWallet.value,
                              onTap: () {
                                DataService.currentUser!.currentWallet = key;
                                _controller.currentWallet.value = key;
                                _controller.curWalletName.value = _controller.wallets[_controller.currentWallet]?.name ?? '';
                                _controller.curWalletAmount.value = _controller.wallets[_controller.currentWallet]?.amount.toString() ?? '';
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

  bool isValidData() {
    if (amountTextController.text.isBlank!) {
      Get.snackbar('', '', titleText: Text('Info'.tr), messageText: Text('Please fill out the amount field'.tr));
      return false;
    } else if (_controller.strCategory.value == '') {
      Get.snackbar('', '', titleText: Text('Info'.tr), messageText: Text('Please fill out the category field'.tr));
      return false;
    } else if (_controller.currentWallet.value == '') {
      Get.snackbar('', '', titleText: Text('Info'.tr), messageText: Text('Please fill out the wallet field'.tr));
      return false;
    }
    return true;
  }
}
