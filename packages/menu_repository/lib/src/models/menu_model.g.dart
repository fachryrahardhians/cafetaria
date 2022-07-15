// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuModel _$MenuModelFromJson(Map<String, dynamic> json) => MenuModel(
      menuId: json['menuId'] as String?,
      merchantId: json['merchantId'] as String?,
      name: json['name'] as String?,
      autoResetStock: json['autoResetStock'] as bool?,
      categoryId: json['categoryId'] as String?,
      desc: json['desc'] as String?,
      image: json['image'] as String?,
      isPreOrder: json['isPreOrder'] as bool?,
      isRecomended: json['isRecomended'] as bool?,
      price: json['price'] as int?,
      resetTime: json['resetTime'] as String?,
      resetType: json['resetType'] as String?,
      rulepreordermenuId: json['rulepreordermenuId'] as String?,
      stock: json['stock'] as int?,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MenuModelToJson(MenuModel instance) => <String, dynamic>{
      'menuId': instance.menuId,
      'merchantId': instance.merchantId,
      'name': instance.name,
      'autoResetStock': instance.autoResetStock,
      'categoryId': instance.categoryId,
      'desc': instance.desc,
      'image': instance.image,
      'isPreOrder': instance.isPreOrder,
      'isRecomended': instance.isRecomended,
      'price': instance.price,
      'resetTime': instance.resetTime,
      'resetType': instance.resetType,
      'rulepreordermenuId': instance.rulepreordermenuId,
      'stock': instance.stock,
      'tags': instance.tags,
    };
