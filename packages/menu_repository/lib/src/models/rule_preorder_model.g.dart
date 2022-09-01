// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_preorder_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RulePreorderModel _$RulePreorderModelFromJson(Map<String, dynamic> json) =>
    RulePreorderModel(
      isShowPublic: json['isShowPublic'] as bool?,
      merchantId: json['merchantId'] as String?,
      pickupTime: json['pickupTime'] as String?,
      maxQty: json['maxQty'] as int?,
      poDay: json['poDay'] as int?,
      rulepreordermenuId: json['rulepreordermenuId'] as String?,
    );

Map<String, dynamic> _$RulePreorderModelToJson(RulePreorderModel instance) =>
    <String, dynamic>{
      'isShowPublic': instance.isShowPublic,
      'merchantId': instance.merchantId,
      'pickupTime': instance.pickupTime,
      'maxQty': instance.maxQty,
      'rulepreordermenuId': instance.rulepreordermenuId,
      'poDay': instance.poDay,
    };
