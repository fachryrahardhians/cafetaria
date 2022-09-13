// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingModel _$RatingModelFromJson(Map<String, dynamic> json) => RatingModel(
      feedback: json['feedback'] as String?,
      merchantId: json['merchantId'] as String?,
      ratingId: json['ratingId'] as String?,
      rating: json['rating'] as int?,
    );

Map<String, dynamic> _$RatingModelToJson(RatingModel instance) =>
    <String, dynamic>{
      'feedback': instance.feedback,
      'merchantId': instance.merchantId,
      'ratingId': instance.ratingId,
      'rating': instance.rating,
    };
