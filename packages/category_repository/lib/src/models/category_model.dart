import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends Equatable {
  const CategoryModel({
    required this.category,
    this.categoryId,
    this.merchantId,
  });

  final String category;
  final String? categoryId;
  final String? merchantId;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  List<Object?> get props => [category, categoryId, merchantId];

  CategoryModel copyWith({
    String? category,
    String? categoryId,
    String? merchantId,
  }) {
    return CategoryModel(
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      merchantId: merchantId ?? this.merchantId,
    );
  }
}
