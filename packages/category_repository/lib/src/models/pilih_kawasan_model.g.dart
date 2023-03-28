// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pilih_kawasan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PilihKawasanModel _$PilihKawasanModelFromJson(Map<String, dynamic> json) =>
    PilihKawasanModel(
      address: json['address'] as String?,
      adminId: json['adminId'] as String,
      kawasanId: json['kawasanId'] as String,
      status: json['status'] as String?,
      kawasan_latitude: (json['kawasan_latitude'] as num?)?.toDouble(),
      kawasan_longitude: (json['kawasan_longitude'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PilihKawasanModelToJson(PilihKawasanModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'adminId': instance.adminId,
      'kawasanId': instance.kawasanId,
      'kawasan_latitude': instance.kawasan_latitude,
      'kawasan_longitude': instance.kawasan_longitude,
      'distance': instance.distance,
      'status': instance.status,
      'name': instance.name,
    };
