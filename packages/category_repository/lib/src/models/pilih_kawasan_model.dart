import 'package:category_repository/src/models/sub_admin_model.dart';
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
  // final double? latitude;
  // final double? longitude;
  final String? namaKawasan;
  // final DateTime updatedAt;
  const PilihKawasanModel({
    this.address,
    required this.adminId,
    required this.kawasanId,
    // required this.createdAt,
    //this.geolocation,
    // this.latitude,
    // this.longitude,
    this.namaKawasan,
    //required this.updatedAt
  });
  factory PilihKawasanModel.fromJson(Map<String, dynamic> json) =>
      _$PilihKawasanModelFromJson(json);

  Map<String, dynamic> toJson() => _$PilihKawasanModelToJson(this);
  @override
  List<Object?> get props => [
        address, adminId, //createdAt, //geolocation,
        kawasanId, 
        // latitude, longitude, 
        namaKawasan //updatedAt
      ];

  PilihKawasanModel copyWith(
      {String? address,
      String? adminId,
      String? kawasanId,
      // double? latitude,
      // double? longitude,
      String? namaKawasan}) {
    return PilihKawasanModel(
        address: address ?? this.address,
        adminId: adminId ?? this.adminId,
        kawasanId: kawasanId ?? this.kawasanId,
        // latitude: latitude ?? this.latitude,
        // longitude: longitude ?? this.longitude,
        namaKawasan: namaKawasan ?? this.namaKawasan);
  }
}
