// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      accessToken: json['accessToken'] as String,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      expiresAt: json['expiresAt'] as int,
      photoUrl: json['photoUrl'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'accessToken': instance.accessToken,
      'username': instance.username,
      'fullName': instance.fullName,
      'expiresAt': instance.expiresAt,
      'photoUrl': instance.photoUrl,
    };
