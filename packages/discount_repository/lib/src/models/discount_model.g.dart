// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountModel _$DiscountModelFromJson(Map<String, dynamic> json) =>
    DiscountModel(
      discount: json['discount'] as int,
      discountId: json['discountId'] as String,
      menuId: json['menuId'] as String,
      merchantId: json['merchantId'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$DiscountModelToJson(DiscountModel instance) =>
    <String, dynamic>{
      'discount': instance.discount,
      'discountId': instance.discountId,
      'menuId': instance.menuId,
      'merchantId': instance.merchantId,
      'type': instance.type,
    };
