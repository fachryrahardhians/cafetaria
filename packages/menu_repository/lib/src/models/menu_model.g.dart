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
      defaultStock: json['defaultStock'] as int?,
      image: json['image'] as String?,
      isPreOrder: json['isPreOrder'] as bool?,
      isRecomended: json['isRecomended'] as bool?,
      price: json['price'] as int?,
      resetTime: json['resetTime'] as String?,
      resetType: json['resetType'] as String?,
      rulepreordermenuId: json['rulepreordermenuId'] as String?,
      // category:
      //     CategoryDetail.fromJson(json['category'] as Map<String, dynamic>),
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
      'defaultStock': instance.defaultStock,
      'isRecomended': instance.isRecomended,
      'category': instance.category?.toJson(),
      'price': instance.price,
      'resetTime': instance.resetTime,
      'resetType': instance.resetType,
      'rulepreordermenuId': instance.rulepreordermenuId,
      'stock': instance.stock,
      'tags': instance.tags,
    };

CategoryDetail _$CategoryDetailFromJson(Map<String, dynamic> json) =>
    CategoryDetail(
      category: json['category'] as String?,
      categoryId: json['categoryId'] as String?,
      merchantId: json['merchantId'] as String?,
    );

Map<String, dynamic> _$CategoryDetailToJson(CategoryDetail instance) =>
    <String, dynamic>{
      'category': instance.category,
      'categoryId': instance.categoryId,
      'merchantId': instance.merchantId,
    };
