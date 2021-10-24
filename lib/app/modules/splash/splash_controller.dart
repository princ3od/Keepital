import 'package:get/get.dart';
import 'package:keepital/app/data/services/app_start_service.dart';
import 'package:keepital/app/data/services/auth_service.dart';
import 'package:keepital/app/routes/pages.dart';

class SplashController extends GetxController {
  @override
  Future<void> onInit() async {
    await AppStartService.instance.initFirebase();
    await Future<void>.delayed(Duration(seconds: 3));
    _navigateNextScreen();
    super.onInit();
  }

  void _navigateNextScreen() {
    if (AuthService.instance.isLogined) {
      Get.offAllNamed(Routes.home);
    }
    Get.offAllNamed(Routes.auth);
  }
}
