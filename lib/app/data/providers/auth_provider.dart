import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthProvider {
  late GoogleSignIn _googleAuthProvider;
  late String fbAcessToken;

  User? getCurrentUser() => FirebaseAuth.instance.currentUser;

  Future<UserCredential?> _signInFirebase({required AuthCredential credential}) async {
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential;
  }

  void signOutFirebase() {
    FirebaseAuth.instance.signOut();
  }

  Future<UserCredential?> signInWithGoogle() async {
    _googleAuthProvider = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await _googleAuthProvider.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken);
      return await _signInFirebase(credential: credential);
    }
  }

  Future signOutGoogle() async {
    await _googleAuthProvider.signOut();
    signOutFirebase();
  }
}
