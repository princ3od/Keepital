import 'package:firebase_auth/firebase_auth.dart';
import 'package:keepital/app/data/providers/auth_provider.dart';
import 'package:keepital/app/enums/app_enums.dart';

class AuthService {
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();

  User? get currentUser => FirebaseAuth.instance.currentUser;
  bool get isLogined => (currentUser != null) ? true : false;
  SignInType get loginType => _loginType;

  SignInType _loginType = SignInType.withGoogle;

  Future<UserCredential?> signInWithGoogle() async {
    _loginType = SignInType.withGoogle;
    return await AuthProvider().signInWithGoogle();
  }

  Future<void> signOut() async {
    if (loginType == SignInType.withGoogle) {
      await AuthProvider().signOutGoogle();
    } else {}
  }
}
