import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/modules/app_setting/setting_controller.dart';
import 'package:keepital/app/modules/app_setting/widget/button_languague.dart';

class SettingScreen extends StatelessWidget {
  final SettingController _settingController = Get.find<SettingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'.tr),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Center(
        child: Container(
          color: Theme.of(context).backgroundColor,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(57, 5, 25, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Text("View".tr, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Default Currency'.tr,
                    textAlign: TextAlign.left,
                  ),
                  InkWell(
                    onTap: () {
                      _settingController.showWalletCurrencyPicker(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).brightness == Brightness.light ? AppColors.textFieldBackgroundLightColor.withOpacity(0.2) : AppColors.textFieldBackgroundDarkColor,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 125,
                          ),
                          Obx(
                            () => Text(
                              '${_settingController.defaultCurrency}',
                            ),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Theme Mode'.tr,
                  ),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        SettingController.defaultThemeMode.value == 'Dark' ? SettingController.defaultThemeMode.value = 'Light' : SettingController.defaultThemeMode.value = 'Dark';
                        _settingController.saveSetting();
                        SettingController.changedThemeMode();
                      },
                      child: Text(
                        '${SettingController.defaultThemeMode}',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Dislay Language'.tr),
                  SizedBox(
                    width: 100,
                    child: LanguagueButton(),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                height: 15,
                thickness: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 15,
              ),
              Text("Notifications".tr, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Show Notificaions'.tr),
                  Obx(
                    () => FlutterSwitch(
                        toggleSize: 15,
                        activeColor: AppColors.primaryColor,
                        inactiveColor: AppColors.primaryColor,
                        width: 45,
                        height: 20,
                        value: _settingController.showNotifications.value,
                        onToggle: (onToggle) async {
                          _settingController.showNotifications.value = onToggle;
                          await _settingController.saveSetting();
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Allow Sound'.tr),
                  Obx(
                    () => FlutterSwitch(
                        toggleSize: 15,
                        activeColor: Color(0xFF38305F),
                        inactiveColor: Color(0xFF38305F),
                        width: 45,
                        height: 20,
                        value: _settingController.allowSound.value,
                        onToggle: (onToggle) async {
                          _settingController.allowSound.value = onToggle;
                          await _settingController.saveSetting();
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
