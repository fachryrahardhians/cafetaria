// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModelChat _$UserModelChatFromJson(Map<String, dynamic> json) =>
    UserModelChat(
      userId: json['userId'] as String,
      address: json['address'] as String,
      email: json['email'] as String?,
      fullname: json['fullname'] as String?,
    );

Map<String, dynamic> _$UserModelChatToJson(UserModelChat instance) =>
    <String, dynamic>{
      'address': instance.address,
      'email': instance.email,
      'fullname': instance.fullname,
      'userId': instance.userId,
    };
