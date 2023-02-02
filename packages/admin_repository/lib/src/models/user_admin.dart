import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_admin.g.dart';

@JsonSerializable(explicitToJson: true)
class UserAdmin extends Equatable {
  // ignore: prefer_typing_uninitialized_variables
  final List<DataAdmin>? adminKawasan;
  final List<DataAdmin>? subAdminKawasan;

  UserAdmin({this.adminKawasan, this.subAdminKawasan
      //required this.updatedAt
      });
  factory UserAdmin.fromJson(Map<String, dynamic> json) =>
      _$UserAdminFromJson(json);

  Map<String, dynamic> toJson() => _$UserAdminToJson(this);
  @override
  List<Object?> get props => [adminKawasan, subAdminKawasan];

  UserAdmin copyWith(
      {List<DataAdmin>? adminKawasan, List<DataAdmin>? subAdminKawasan}) {
    return UserAdmin(
      adminKawasan: adminKawasan ?? this.adminKawasan,
      subAdminKawasan: subAdminKawasan ?? this.subAdminKawasan,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DataAdmin extends Equatable {
  // ignore: prefer_typing_uninitialized_variables

  final double? kawasan_longitude;
  final String? address;
  final String? name;
  final String? kawasanId;
  final String? status;
  final double? kawasan_latitude;

  const DataAdmin({
    this.kawasan_longitude,
    this.address,
    this.name,
    this.kawasanId,
    // required this.createdAt,
    //this.geolocation,
    this.status,
    this.kawasan_latitude,
    //required this.updatedAt
  });
  factory DataAdmin.fromJson(Map<String, dynamic> json) =>
      _$DataAdminFromJson(json);

  Map<String, dynamic> toJson() => _$DataAdminToJson(this);
  @override
  List<Object?> get props => [
        kawasan_longitude, address, //createdAt, //geolocation,
        kawasanId,
        name, status,
        kawasan_latitude,
      ];

  DataAdmin copyWith({
    double? kawasan_longitude,
    String? address,
    String? name,
    String? kawasanId,
    String? status,
    double? kawasan_latitude,
  }) {
    return DataAdmin(
      kawasan_longitude: kawasan_longitude ?? this.kawasan_longitude,
      address: address ?? this.address,
      kawasanId: kawasanId ?? this.kawasanId,
      name: name ?? this.name,
      status: status ?? this.status,
      kawasan_latitude: kawasan_latitude ?? this.kawasan_latitude,
    );
  }
}
