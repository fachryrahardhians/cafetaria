// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MechantSearch _$MechantSearchFromJson(Map<String, dynamic> json) =>
    MechantSearch(
      type: json['_type'] as String?,
      score: json['_score'] as int?,
      id: json['_id'] as String?,
      index: json['_index'] as String?,
      source: json['_source'] == null
          ? null
          : MerchantSearchModel.fromJson(
              Map<String, dynamic>.from(json['_source'])),
    );

Map<String, dynamic> _$MechantSearchToJson(MechantSearch instance) =>
    <String, dynamic>{
      '_type': instance.type,
      '_score': instance.score,
      '_id': instance.id,
      '_source': instance.source?.toJson(),
      '_index': instance.index,
    };
