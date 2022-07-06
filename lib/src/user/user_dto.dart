import 'package:firebase_auth/firebase_auth.dart';

class UserDto {
  final User user;
  final String token;
  UserDto(this.user, this.token);
  Map<String, dynamic> toJson() => {
        'name': user.displayName,
        'email': user.email,
        'authToken': token,
        'phone': user.phoneNumber,
        'photoUrl': user.photoURL,
      };
}
