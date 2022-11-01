// ignore_for_file: public_member_api_docs, non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
// ignore: public_member_api_docs
class MerchantModel extends Equatable {
  const MerchantModel(
      {this.maxPrice,
      this.merchantId,
      this.minPrice,
      this.name,
      this.rating,
      this.test,
      this.image,
      this.totalCountRating,
      this.totalOrderToday,
      this.totalSalesToday,
      this.totalSalesYesterday,
      this.buka_toko,
      this.userId,
      this.tutup_toko,
      this.address,
      this.address_detail,
      this.address_latitude,
      this.address_longitude});

  factory MerchantModel.fromJson(Map<String, dynamic> json) =>
      _$MerchantModelFromJson(json);
  final int? maxPrice;
  final String? merchantId;
  final int? minPrice;
  final String? name;
  final double? rating;
  final String? test;
  final String? image;
  final int? totalCountRating;
  final int? totalOrderToday;
  final int? totalSalesToday;
  final int? totalSalesYesterday;
  final String? userId;
  final String? address;
  final String? buka_toko;
  final String? tutup_toko;
  final String? address_detail;
  final double? address_latitude;
  final double? address_longitude;

  Map<String, dynamic> toJson() => _$MerchantModelToJson(this);

  /// Copy with a new [MerchantModel].
  MerchantModel copyWith(
      {int? maxPrice,
      String? merchantId,
      int? minPrice,
      String? tutup_toko,
      String? buka_toko,
      String? name,
      String? image,
      double? rating,
      String? test,
      int? totalCountRating,
      int? totalOrderToday,
      int? totalSalesToday,
      int? totalSalesYesterday,
      String? userId,
      String? address,
      String? address_detail,
      double? address_latitude,
      double? address_longitude}) {
    return MerchantModel(
      maxPrice: maxPrice ?? this.maxPrice,
      merchantId: merchantId ?? this.merchantId,
      minPrice: minPrice ?? this.minPrice,
      name: name ?? this.name,
      buka_toko: buka_toko ?? this.buka_toko,
      tutup_toko: tutup_toko ?? this.tutup_toko,
      rating: rating ?? this.rating,
      test: test ?? this.test,
      image: image ?? this.image,
      totalCountRating: totalCountRating ?? this.totalCountRating,
      totalOrderToday: totalOrderToday ?? this.totalOrderToday,
      totalSalesToday: totalSalesToday ?? this.totalSalesToday,
      totalSalesYesterday: totalSalesYesterday ?? this.totalSalesYesterday,
      userId: userId ?? this.userId,
      address: address ?? this.address,
      address_detail: address_detail ?? this.address_detail,
      address_latitude: address_latitude ?? this.address_latitude,
      address_longitude: address_longitude ?? this.address_longitude,
    );
  }

  @override
  List<Object?> get props => [];
}
