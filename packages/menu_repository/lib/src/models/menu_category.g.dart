// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuCategory _$MenuCategoryFromJson(Map<String, dynamic> json) => MenuCategory(
      category: json['category'] as String?,
      menu: (json['menu'] as List<dynamic>?)
          ?.map((e) => MenuModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );

Map<String, dynamic> _$MenuCategoryToJson(MenuCategory instance) =>
    <String, dynamic>{
      'category': instance.category,
      'menu': instance.menu?.map((e) => e.toJson()).toList(),
    };
