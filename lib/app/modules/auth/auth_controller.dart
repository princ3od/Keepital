import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/models/keepital_user.dart';
import 'package:keepital/app/data/providers/user_provider.dart';
import 'package:keepital/app/data/services/auth_service.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/routes/pages.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var _userProvider = UserProvider();

  handleSignIn(SignInType signInType) async {
    try {
      _startLoading();
      var result = await _signIn(signInType);
      if (null != result) {
        await _onSignInSuccess(result);
      } else {
        await _onSignInFail();
      }
    } finally {
      _finishLoading();
    }
  }

  Future<UserCredential?> _signIn(SignInType signInType) async {
    if (signInType == SignInType.withGoogle) {
      return await AuthService.instance.signInWithGoogle();
    } else {
      // await AuthService.instance.signInWithFacebook();
      return null;
    }
  }

  Future<void> _onSignInSuccess(UserCredential result) async {
    bool isExist = await _isUserExists(result.user!.uid);
    if (isExist) {
      await DataService.instance.loadUserData();
    } else {
      await _createUser(result.user);
    }
    _navigateToSuitableScreen();
  }

  _startLoading() => isLoading.value = true;
  _finishLoading() => isLoading.value = false;
  _isUserExists(String id) async => await _userProvider.isExists(id);

  _onSignInFail() {
    //
  }

  _createUser(User? user) async {
    KeepitalUser keepitalUser = KeepitalUser(user!.uid, amount: 0, currencyId: '0', name: user.displayName);
    DataService.currentUser = await _userProvider.add(keepitalUser);
  }

  _navigateToSuitableScreen() {
    if (DataService.currentUser!.hasAnyWallet) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.firstWallet);
    }
  }
}
