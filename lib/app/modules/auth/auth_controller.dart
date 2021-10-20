import 'package:get/get.dart';
import 'package:keepital/app/data/services/auth_service.dart';
import 'package:keepital/app/routes/pages.dart';

class AuthController extends GetxController {
  signInWithGoogle() async {
    await AuthService.instance.signInWithGoogle();
    Get.toNamed(Routes.home);
  }
}
