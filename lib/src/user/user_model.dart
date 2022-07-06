import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  final String id;
  final String accessToken;
  final String username;
  final String fullName;
  final int expiresAt;
  final String photoUrl;
  UserModel({
    required this.id,
    required this.accessToken,
    required this.username,
    required this.fullName,
    required this.expiresAt,
    required this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
