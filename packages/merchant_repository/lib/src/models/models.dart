import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class MerchantModel extends Equatable {
  //final List<String> tags;

  MerchantModel({
    this.userId,
    this.merchantId,
    this.name,
    this.address,
    this.address_detail,
    this.address_latitude,
    this.address_longitud,
    this.category,
    this.city,
    this.create_at,
    this.maxPrice,
    this.photo_from_inside,
    this.photo_from_outside,
    this.postal_code,
  });
  final String? userId;
  final String? merchantId;
  final String? name;
  final String? address;
  final String? address_detail;
  final double? address_latitude;
  final double? address_longitud;
  final String? category;
  final String? city;
  final DateTime? create_at;
  final int? maxPrice;
  final String? photo_from_inside;
  final String? photo_from_outside;
  final String? postal_code;
  
  factory MerchantModel.fromJson(Map<String, dynamic> json) =>
      _$MerchantModelFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantModelToJson(this);

  /// Copy with a new [MerchantModel].
  MerchantModel copyWith({
    String? userId,
    String? merchantId,
    String? name,
    String? address,
    String? address_detail,
    double? address_latitude,
    double? address_longitud,
    String? category,
    String? city,
    DateTime? create_at,
    int? maxPrice,
    String? photo_from_inside,
    String? photo_from_outside,
    String? postal_code,
  }) {
    return MerchantModel(
      userId: userId ?? this.userId,
      merchantId: merchantId ?? this.merchantId,
      name: name ?? this.name,
      address: address ?? this.address,
      address_detail: address_detail ?? this.address_detail,
      address_latitude: address_latitude ?? this.address_latitude,
      address_longitud: address_longitud ?? this.address_longitud,
      category: category ?? this.category,
      city: city ?? this.city,
      create_at: create_at ?? this.create_at,
      maxPrice: maxPrice ?? this.maxPrice,
      photo_from_inside: photo_from_inside ?? this.photo_from_inside,
      photo_from_outside: photo_from_outside ?? this.photo_from_outside,
      postal_code: postal_code ?? this.postal_code,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        merchantId,
        name,
        address,
        address_detail,
        address_latitude,
        address_longitud,
        category,
        city,
        create_at,
        maxPrice,
        photo_from_inside,
        photo_from_outside,
        postal_code,
      ];
}
