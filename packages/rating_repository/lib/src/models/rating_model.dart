// ignore_for_file: public_member_api_docs, sort_unnamed_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel extends Equatable {
  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);

  const RatingModel({
    this.feedback,
    this.merchantId,
    this.orderId,
    this.ratingId,
    this.userId,
    this.rating,
  });
  final String? feedback;
  final String? merchantId;
  final String? orderId;
  final String? ratingId;
  final String? userId;
  final int? rating;

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);

  RatingModel copyWith({
    String? feedback,
    String? merchantId,
    String? orderId,
    String? ratingId,
    String? userId,
    int? rating,
  }) {
    return RatingModel(
      feedback: feedback ?? this.feedback,
      orderId: orderId ?? this.orderId,
      rating: rating ?? this.rating,
      ratingId: ratingId ?? this.ratingId,
      userId: userId ?? this.userId,
      merchantId: merchantId ?? this.merchantId,
    );
  }

  @override
  List<Object?> get props =>
      [feedback, orderId, merchantId, ratingId, rating, userId];
}
