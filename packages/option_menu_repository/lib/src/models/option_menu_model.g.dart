// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionMenuModel _$OptionMenuModelFromJson(Map<String, dynamic> json) =>
    OptionMenuModel(
      isMandatory: json['isMandatory'] as bool,
      isMultipleTopping: json['isMultipleTopping'] as bool,
      menuId: json['menuId'] as String?,
      optionmenuId: json['optionmenuId'] as String,
      title: json['title'] as String,
      option: (json['option'] as List<dynamic>)
          .map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OptionMenuModelToJson(OptionMenuModel instance) =>
    <String, dynamic>{
      'isMandatory': instance.isMandatory,
      'isMultipleTopping': instance.isMultipleTopping,
      'menuId': instance.menuId,
      'optionmenuId': instance.optionmenuId,
      'title': instance.title,
      'option': instance.option.map((e) => e.toJson()).toList(),
    };
