// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantModel _$MerchantModelFromJson(Map<String, dynamic> json) =>
    MerchantModel(
      maxPrice: json['maxPrice'] as int?,
      merchantId: json['merchantId'] as String?,
      minPrice: json['minPrice'] as int?,
      name: json['name'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      test: json['test'] as String?,
      totalCountRating: json['totalCountRating'] as int?,
      totalOrderToday: json['totalOrderToday'] as int?,
      totalSalesToday: json['totalSalesToday'] as int?,
      totalSalesYesterday: json['totalSalesYesterday'] as int?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$MerchantModelToJson(MerchantModel instance) =>
    <String, dynamic>{
      'maxPrice': instance.maxPrice,
      'merchantId': instance.merchantId,
      'minPrice': instance.minPrice,
      'name': instance.name,
      'rating': instance.rating,
      'test': instance.test,
      'totalCountRating': instance.totalCountRating,
      'totalOrderToday': instance.totalOrderToday,
      'totalSalesToday': instance.totalSalesToday,
      'totalSalesYesterday': instance.totalSalesYesterday,
      'userId': instance.userId,
    };
