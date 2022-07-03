import 'package:app/src/common/exceptions/authentication_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthService {
  static final FacebookAuthService _singleton =
      FacebookAuthService._constructor();
  Map<String, dynamic>? _user;
  // Empty, private constructor => singleton
  FacebookAuthService._constructor();
  static FacebookAuthService get instance => _singleton;

  get user {
    return _user!;
  }

  Future<void> login() async {
    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      _user = await FacebookAuth.instance.getUserData();
      final credential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw AuthenticationException(e);
    }
  }

  Future<void> logout() async {
    await FacebookAuth.instance.logOut();
    FirebaseAuth.instance.signOut();
  }
}
