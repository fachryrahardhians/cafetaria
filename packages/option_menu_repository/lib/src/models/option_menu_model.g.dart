// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionMenuModel _$OptionMenuModelFromJson(Map<String, dynamic> json) => OptionMenuModel(
      autoResetStock: json['autoResetStock'] as bool?,
      category: (json['category'] as List<dynamic>).map((e) => e as String).toList(),
      categoryId: json['categoryId'] as String?,
      desc: json['desc'] as String?,
      image: json['image'] as String?,
      isPreOrder: json['isPreOrder'] as bool?,
      isRecomended: json['isRecomended'] as bool?,
      menuId: json['menuId'] as String?,
      merchant: json['merchant'] as String?,
      merchantId: json['merchantId'] as String?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      resetTime: json['resetTime'] as String?,
      resetType: json['resetType'] as String?,
      rulepreorder: json['rulepreorder'] as String?,
      rulepreordermenuId: json['rulepreordermenuId'] as String?,
      options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      stock: json['stock'] as int?,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$OptionMenuModelToJson(OptionMenuModel instance) => <String, dynamic>{
      'autoResetStock': instance.autoResetStock,
      'category': instance.category,
      'categoryId': instance.categoryId,
      'desc': instance.desc,
      'image': instance.image,
      'isPreOrder': instance.isPreOrder,
      'isRecomended': instance.isRecomended,
      'menuId': instance.menuId,
      'merchant': instance.merchant,
      'merchantId': instance.merchantId,
      'name': instance.name,
      'options': instance.options,
      'price': instance.price,
      'resetTime': instance.resetTime,
      'resetType': instance.resetType,
      'rulepreorder': instance.rulepreorder,
      'rulepreordermenuId': instance.rulepreordermenuId,
      'stock': instance.stock,
      'tags': instance.tags,
    };
