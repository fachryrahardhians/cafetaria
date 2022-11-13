import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'merchant_search_model.g.dart';
@JsonSerializable()
class MerchantSearchModel extends Equatable {
  const MerchantSearchModel(
      {this.address, this.category, this.city, this.name, this.rating});
  factory MerchantSearchModel.fromJson(Map<String, dynamic> json) =>
      _$MerchantSearchModelFromJson(json);
  final String? address;
  final String? name;
  final int? rating;
  final String? category;
  final String? city;

  Map<String, dynamic> toJson() => _$MerchantSearchModelToJson(this);
  MerchantSearchModel copyWith(
      {String? address,
      String? name,
      int? rating,
      String? category,
      String? city}) {
    return MerchantSearchModel(
        address: address ?? this.address,
        category: category ?? this.category,
        city: city ?? this.city,
        name: name ?? this.name,
        rating: rating ?? this.rating);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
