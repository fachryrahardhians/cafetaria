// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantModel _$MerchantModelFromJson(Map<String, dynamic> json) =>
    MerchantModel(
      maxPrice: json['maxPrice'] as int?,
      merchantId: json['merchantId'] as String?,
      minPrice: json['minPrice'] as int?,
      tutup_toko: json['tutup_toko'] as String?,
      name: json['name'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      test: json['test'] as String?,
      totalCountRating: json['totalCountRating'] as int?,
      totalOrderToday: json['totalOrderToday'] as int?,
      totalSalesToday: json['totalSalesToday'] as int?,
      totalSalesYesterday: json['totalSalesYesterday'] as int?,
      userId: json['userId'] as String?,
      address: json['address'] as String?,
      address_detail: json['address_detail'] as String?,
      address_latitude: (json['address_latitude'] as num?)?.toDouble(),
      address_longitude: (json['address_longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MerchantModelToJson(MerchantModel instance) =>
    <String, dynamic>{
      'maxPrice': instance.maxPrice,
      'merchantId': instance.merchantId,
      'minPrice': instance.minPrice,
      'name': instance.name,
      'rating': instance.rating,
      'tutup_toko': instance.tutup_toko,
      'test': instance.test,
      'totalCountRating': instance.totalCountRating,
      'totalOrderToday': instance.totalOrderToday,
      'totalSalesToday': instance.totalSalesToday,
      'totalSalesYesterday': instance.totalSalesYesterday,
      'userId': instance.userId,
      'address': instance.address,
      'address_detail': instance.address_detail,
      'address_latitude': instance.address_latitude,
      'address_longitude': instance.address_longitude,
    };
