// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAdmin _$UserAdminFromJson(Map<String, dynamic> json) => UserAdmin(
      adminKawasan: (json['adminKawasan'] as List<dynamic>?)
          ?.map((e) => DataAdmin.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      subAdminKawasan: (json['subAdminKawasan'] as List<dynamic>?)
          ?.map((e) => DataAdmin.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );

Map<String, dynamic> _$UserAdminToJson(UserAdmin instance) => <String, dynamic>{
      'adminKawasan': instance.adminKawasan?.map((e) => e.toJson()).toList(),
      'subAdminKawasan':
          instance.subAdminKawasan?.map((e) => e.toJson()).toList(),
    };

DataAdmin _$DataAdminFromJson(Map<String, dynamic> json) => DataAdmin(
      kawasan_longitude: (json['kawasan_longitude'] as num?)?.toDouble(),
      address: json['address'] as String?,
      name: json['name'] as String?,
      kawasanId: json['kawasanId'] as String?,
      status: json['status'] as String?,
      kawasan_latitude: (json['kawasan_latitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DataAdminToJson(DataAdmin instance) => <String, dynamic>{
      'kawasan_longitude': instance.kawasan_longitude,
      'address': instance.address,
      'name': instance.name,
      'kawasanId': instance.kawasanId,
      'status': instance.status,
      'kawasan_latitude': instance.kawasan_latitude,
    };
