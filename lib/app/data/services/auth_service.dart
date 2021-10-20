import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/providers/auth_provider.dart';

class AuthService {
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();

  User? get currentUser => FirebaseAuth.instance.currentUser;
  bool get isLogined => (currentUser != null) ? true : false;

  Future<UserCredential?> signInWithGoogle() async => await AuthProvider().signInWithGoogle();
}
