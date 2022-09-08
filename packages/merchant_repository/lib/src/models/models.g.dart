// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantModel _$MerchantModelFromJson(Map<String, dynamic> json) =>
    MerchantModel(
      userId: json['userId'] as String?,
      merchantId: json['merchantId'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      address_detail: json['address_detail'] as String?,
      address_latitude: (json['address_latitude'] as num?)?.toDouble(),
      address_longitud: (json['address_longitud'] as num?)?.toDouble(),
      category: json['category'] as String?,
      city: json['city'] as String?,
      create_at: json['create_at'] == null
          ? null
          : (json['create_at'] as Timestamp).toDate(),
      maxPrice: json['maxPrice'] as int?,
      photo_from_inside: json['photo_from_inside'] as String?,
      photo_from_outside: json['photo_from_outside'] as String?,
      postal_code: json['postal_code'] as String?,
    );

Map<String, dynamic> _$MerchantModelToJson(MerchantModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'merchantId': instance.merchantId,
      'name': instance.name,
      'address': instance.address,
      'address_detail': instance.address_detail,
      'address_latitude': instance.address_latitude,
      'address_longitud': instance.address_longitud,
      'category': instance.category,
      'city': instance.city,
      'create_at': instance.create_at?.toIso8601String(),
      'maxPrice': instance.maxPrice,
      'photo_from_inside': instance.photo_from_inside,
      'photo_from_outside': instance.photo_from_outside,
      'postal_code': instance.postal_code,
    };
