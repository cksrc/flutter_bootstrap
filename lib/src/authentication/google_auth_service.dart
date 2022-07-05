import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../common/exceptions/authentication_exception.dart';

class GoogleAuthService {
  static final GoogleAuthService _singleton = GoogleAuthService._constructor();
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  // Empty, private constructor => singleton
  GoogleAuthService._constructor();
  static GoogleAuthService get instance => _singleton;

  GoogleSignInAccount get user {
    return _user!;
  }

  Future login() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw AuthenticationException(e);
    }
  }

  Future logout() async {
    await _googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }
}
