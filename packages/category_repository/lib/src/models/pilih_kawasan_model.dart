import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pilih_kawasan_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PilihKawasanModel {
  final String? address;
  final String adminId;
  // final DateTime createdAt;
  //final GeoPoint? geolocation;
  final String kawasanId;
  final double? kawasan_latitude;
  final double? kawasan_longitude;
  final String? status;
  final String? name;
  // final DateTime updatedAt;
  const PilihKawasanModel({
    this.address,
    required this.adminId,
    required this.kawasanId,
    // required this.createdAt,
    //this.geolocation,
    this.status,
    this.kawasan_latitude,
    this.kawasan_longitude,
    this.name,
    //required this.updatedAt
  });
  factory PilihKawasanModel.fromJson(Map<String, dynamic> json) =>
      _$PilihKawasanModelFromJson(json);

  Map<String, dynamic> toJson() => _$PilihKawasanModelToJson(this);
  @override
  List<Object?> get props => [
        address, adminId, //createdAt, //geolocation,
        kawasanId,
        kawasan_latitude, kawasan_longitude,
        status,
        name //updatedAt
      ];

  PilihKawasanModel copyWith(
      {String? address,
      String? adminId,
      String? kawasanId,
      String? status,
      double? kawasan_latitude,
      double? kawasan_longitude,
      String? name}) {
    return PilihKawasanModel(
        address: address ?? this.address,
        adminId: adminId ?? this.adminId,
        kawasanId: kawasanId ?? this.kawasanId,
        status: status ?? this.status,
        kawasan_latitude: kawasan_latitude ?? this.kawasan_latitude,
        kawasan_longitude: kawasan_longitude ?? this.kawasan_longitude,
        name: name ?? this.name);
  }
}
