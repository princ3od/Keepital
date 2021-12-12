import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:keepital/app/modules/app_setting/setting_controller.dart';

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
