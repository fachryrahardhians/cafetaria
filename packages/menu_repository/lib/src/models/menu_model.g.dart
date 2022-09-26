// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuModel _$MenuModelFromJson(Map<String, dynamic> json) => MenuModel(
      menuId: json['menuId'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OpsiMenu.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      stock: json['stock'] as int?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
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
      'price': instance.price,
      'resetTime': instance.resetTime,
      'resetType': instance.resetType,
      'rulepreordermenuId': instance.rulepreordermenuId,
      'options': instance.options?.map((e) => e.toJson()).toList(),
      'stock': instance.stock,
      'tags': instance.tags,
    };

OpsiMenu _$OpsiMenuFromJson(Map<String, dynamic> json) => OpsiMenu(
      isMandatory: json['isMandatory'] as bool?,
      isMultipleTopping: json['isMultipleTopping'] as bool?,
      menuId: json['menuId'] as String?,
      option: (json['option'] as List<dynamic>?)
          ?.map((e) => Options.fromJson(e as Map<String, dynamic>))
          .toList(),
      optionmenuId: json['optionmenuId'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$OpsiMenuToJson(OpsiMenu instance) => <String, dynamic>{
      'isMandatory': instance.isMandatory,
      'isMultipleTopping': instance.isMultipleTopping,
      'menuId': instance.menuId,
      'option': instance.option,
      'optionmenuId': instance.optionmenuId,
      'title': instance.title,
    };

Options _$OptionFromJson(Map<String, dynamic> json) => Options(
      name: json['name'] as String?,
      price: json['price'] as int?,
    );

Map<String, dynamic> _$OptionToJson(Options instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
    };
