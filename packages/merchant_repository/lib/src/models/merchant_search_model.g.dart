// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantSearchModel _$MerchantSearchModelFromJson(Map<String, dynamic> json) =>
    MerchantSearchModel(
      address: json['address'] as String?,
      category: json['category'] as String?,
      city: json['city'] as String?,
      name: json['name'] as String?,
      rating: json['rating'] as int?,
    );

Map<String, dynamic> _$MerchantSearchModelToJson(
        MerchantSearchModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'rating': instance.rating,
      'category': instance.category,
      'city': instance.city,
    };
