// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingModel _$RatingModelFromJson(Map<String, dynamic> json) => RatingModel(
      feedback: json['feedback'] as String?,
      merchantId: json['merchantId'] as String?,
      orderId: json['orderId'] as String?,
      ratingId: json['ratingId'] as String?,
      userId: json['userId'] as String?,
      rating: json['rating'] as int?,
    );

Map<String, dynamic> _$RatingModelToJson(RatingModel instance) =>
    <String, dynamic>{
      'feedback': instance.feedback,
      'merchantId': instance.merchantId,
      'orderId': instance.orderId,
      'ratingId': instance.ratingId,
      'userId': instance.userId,
      'rating': instance.rating,
    };
