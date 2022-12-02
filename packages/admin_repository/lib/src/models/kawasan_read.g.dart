// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kawasan_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KawasanRead _$KawasanReadFromJson(Map<String, dynamic> json) => KawasanRead(
      address: json['address'] as String?,
      adminId: json['adminId'] as String,
      kawasanId: json['kawasanId'] as String,
      admin: UserModel.fromJson(json['admin'] as Map<String, dynamic>),
      kawasan_latitude: (json['kawasan_latitude'] as num?)?.toDouble(),
      kawasan_longitude: (json['kawasan_longitude'] as num?)?.toDouble(),
      name: json['name'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$KawasanReadToJson(KawasanRead instance) =>
    <String, dynamic>{
      'address': instance.address,
      'adminId': instance.adminId,
      'kawasanId': instance.kawasanId,
      'kawasan_latitude': instance.kawasan_latitude,
      'kawasan_longitude': instance.kawasan_longitude,
      'admin': instance.admin.toJson(),
      'name': instance.name,
      'status': instance.status,
    };
