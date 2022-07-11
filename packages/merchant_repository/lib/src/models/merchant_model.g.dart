// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantModel _$MerchantModelFromJson(Map<String, dynamic> json) =>
    MerchantModel(
      maxPrice: json['maxPrice'] as String?,
      merchantId: json['merchantId'] as String?,
      minPrice: json['minPrice'] as String?,
      nama: json['nama'] as String?,
      rating: json['rating'] as String?,
      test: json['test'] as String?,
      totalCountRating: json['totalCountRating'] as String?,
      totalOrderToday: json['totalOrderToday'] as String?,
      totalSalesToday: json['totalSalesToday'] as String?,
      totalSalesYesterday: json['totalSalesYesterday'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$MerchantModelToJson(MerchantModel instance) =>
    <String, dynamic>{
      'maxPrice': instance.maxPrice,
      'merchantId': instance.merchantId,
      'minPrice': instance.minPrice,
      'nama': instance.nama,
      'rating': instance.rating,
      'test': instance.test,
      'totalCountRating': instance.totalCountRating,
      'totalOrderToday': instance.totalOrderToday,
      'totalSalesToday': instance.totalSalesToday,
      'totalSalesYesterday': instance.totalSalesYesterday,
      'userId': instance.userId,
    };
