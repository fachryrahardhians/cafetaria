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
    this.ratingId,
    this.rating,
  });
  final String? feedback;
  final String? merchantId;
  final String? ratingId;
  final int? rating;

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);

  RatingModel copyWith(
      {String? feedback, String? merchantId, String? ratingId, int? rating}) {
    return RatingModel(
      feedback: feedback ?? this.feedback,
      rating: rating ?? this.rating,
      ratingId: ratingId ?? this.ratingId,
      merchantId: merchantId ?? this.merchantId,
    );
  }

  @override
  List<Object?> get props => [feedback, merchantId, ratingId, rating];
}
