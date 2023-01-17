import 'package:admin_repository/src/models/user_model.dart';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kawasan_read.g.dart';

@JsonSerializable(explicitToJson: true)
class KawasanRead extends Equatable {
  final String? address;
  final String adminId;
  // final DateTime createdAt;
  //final GeoPoint? geolocation;
  final String kawasanId;
  final double? kawasan_latitude;
  final double? kawasan_longitude;
  final UserModel admin;
  final String? name;
  final String? status;
  // final DateTime updatedAt;
  const KawasanRead(
      {this.address,
      required this.adminId,
      required this.kawasanId,
      required this.admin,
      // required this.createdAt,
      //this.geolocation,
      this.kawasan_latitude,
      this.kawasan_longitude,
      this.name,
      this.status
      //required this.updatedAt
      });
  factory KawasanRead.fromJson(Map<String, dynamic> json) =>
      _$KawasanReadFromJson(json);

  Map<String, dynamic> toJson() => _$KawasanReadToJson(this);
  @override
  List<Object?> get props => [
        address, adminId, //createdAt, //geolocation,
        kawasanId,
        kawasan_latitude, kawasan_longitude,
        name,
        admin,
        status
      ];

  KawasanRead copyWith(
      {String? address,
      String? adminId,
      String? kawasanId,
      double? kawasan_latitude,
      double? kawasan_longitude,
      UserModel? admin,
      String? status,
      String? name}) {
    return KawasanRead(
        address: address ?? this.address,
        adminId: adminId ?? this.adminId,
        kawasanId: kawasanId ?? this.kawasanId,
        kawasan_latitude: kawasan_latitude ?? this.kawasan_latitude,
        kawasan_longitude: kawasan_longitude ?? this.kawasan_longitude,
        admin: admin ?? this.admin,
        status: status ?? this.status,
        name: name ?? this.name);
  }
}
