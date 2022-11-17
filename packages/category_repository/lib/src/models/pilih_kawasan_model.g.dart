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
      namaKawasan: json['namaKawasan'] as String?,
    );

Map<String, dynamic> _$PilihKawasanModelToJson(PilihKawasanModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'adminId': instance.adminId,
      'kawasanId': instance.kawasanId,
      'namaKawasan': instance.namaKawasan,
    };
