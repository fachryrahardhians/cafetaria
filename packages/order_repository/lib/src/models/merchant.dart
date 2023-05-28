// ignore_for_file: public_member_api_docs, non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'merchant.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: public_member_api_docs
class MerchantModelHistory extends Equatable {
  const MerchantModelHistory(
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
      this.distance,
      this.buka_toko,
      this.userId,
      this.tutup_toko,
      this.address,
      this.city,
      this.postal_code,
      this.address_detail,
      this.address_latitude,
      this.address_longitude});

  factory MerchantModelHistory.fromJson(Map<String, dynamic> json) =>
      _$MerchantModelHistoryFromJson(json);
  final int? maxPrice;
  final String? merchantId;
  final int? minPrice;
  final String? name;
  final double? rating;
  final double? distance;
  final String? test;
  final String? image;
  final String? city;
  final String? postal_code;
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

  Map<String, dynamic> toJson() => _$MerchantModelHistoryToJson(this);

  /// Copy with a new [MerchantModelHistory].
  MerchantModelHistory copyWith(
      {int? maxPrice,
      String? merchantId,
      int? minPrice,
      String? tutup_toko,
      String? buka_toko,
      String? postal_code,
      String? name,
      String? image,
      double? rating,
      String? test,
      String? city,
      int? totalCountRating,
      int? totalOrderToday,
      int? totalSalesToday,
      int? totalSalesYesterday,
      String? userId,
      String? address,
      String? address_detail,
      double? address_latitude,
      double? distance,
      double? address_longitude}) {
    return MerchantModelHistory(
      maxPrice: maxPrice ?? this.maxPrice,
      merchantId: merchantId ?? this.merchantId,
      minPrice: minPrice ?? this.minPrice,
      name: name ?? this.name,
      buka_toko: buka_toko ?? this.buka_toko,
      tutup_toko: tutup_toko ?? this.tutup_toko,
      rating: rating ?? this.rating,
      distance: distance ?? this.distance,
      test: test ?? this.test,
      city: city ?? this.city,
      postal_code: postal_code ?? this.postal_code,
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