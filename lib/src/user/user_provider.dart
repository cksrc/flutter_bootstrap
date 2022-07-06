import 'package:app/src/common/exceptions/authentication_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'user_model.dart';

enum SignInMethod { google, facebook, apple }

class UserProvider with ChangeNotifier {
  UserModel? user;
  void setUser() async {
    User? socialUser = FirebaseAuth.instance.currentUser;
    if (socialUser == null) return;
    try {
      user = await _serverLogin(socialUser);
    } catch (e) {
      throw AuthenticationException(e);
    }
    notifyListeners();
  }

  Future<UserModel?> _serverLogin(User socialUser) async {
    //TODO: implement server side login and return a user or throw an error
    return Future<UserModel>(() => UserModel(
        id: 'id',
        accessToken: 'accessToken',
        username: 'username',
        fullName: 'fullName',
        expiresAt: 1,
        photoUrl: 'photoUrl'));
  }
}
