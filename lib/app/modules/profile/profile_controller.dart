import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/services/auth_service.dart';
import 'package:keepital/app/enums/app_enums.dart';

class ProfileController extends GetxController {
  User? currentUser = AuthService.instance.currentUser;
  SignInType loginType = AuthService.instance.loginType;
}
