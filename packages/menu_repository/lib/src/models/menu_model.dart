import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'menu_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MenuModel extends Equatable {
  final String? menuId;
  final String? merchantId;
  final String? name;
  final bool? autoResetStock;
  final String? categoryId;
  final String? desc;
  final String? image;
  final bool? isPreOrder;
  final int? defaultStock;
  final bool? isRecomended;
  final CategoryDetail? category;
  final int? price;
  final String? resetTime;
  final String? resetType;
  final String? rulepreordermenuId;
  final int? stock;
  final List<String> tags;

  const MenuModel({
    this.menuId,
    this.merchantId,
    this.name,
    this.autoResetStock,
    this.categoryId,
    this.desc,
    this.defaultStock,
    this.image,
    this.isPreOrder,
    this.isRecomended,
    this.price,
    this.resetTime,
    this.resetType,
    this.rulepreordermenuId,
    this.category,
    this.stock,
    required this.tags,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenuModelToJson(this);

  /// Copy with a new [MenuModel].
  MenuModel copyWith({
    String? menuId,
    int? defaultStock,
    String? merchantId,
    String? name,
    bool? autoResetStock,
    String? categoryId,
    String? desc,
    String? image,
    bool? isPreOrder,
    bool? isRecomended,
    int? price,
    String? resetTime,
    String? resetType,
    String? rulepreordermenuId,
    int? stock,
    List<String>? tags,
    CategoryDetail? category,
  }) {
    return MenuModel(
      menuId: menuId ?? this.menuId,
      merchantId: merchantId ?? this.merchantId,
      name: name ?? this.name,
      autoResetStock: autoResetStock ?? this.autoResetStock,
      categoryId: categoryId ?? this.categoryId,
      desc: desc ?? this.desc,
      defaultStock: defaultStock ?? this.defaultStock,
      image: image ?? this.image,
      isPreOrder: isPreOrder ?? this.isPreOrder,
      isRecomended: isRecomended ?? this.isRecomended,
      price: price ?? this.price,
      resetTime: resetTime ?? this.resetTime,
      resetType: resetType ?? this.resetType,
      rulepreordermenuId: rulepreordermenuId ?? this.rulepreordermenuId,
      stock: stock ?? this.stock,
      tags: tags ?? this.tags,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
        menuId,
        merchantId,
        name,
        autoResetStock,
        categoryId,
        desc,
        image,
        isPreOrder,
        isRecomended,
        price,
        resetTime,
        resetType,
        rulepreordermenuId,
        stock,
        tags
      ];
}

@JsonSerializable()
class CategoryDetail extends Equatable {
  final String? category;
  final String? categoryId;
  final String? merchantId;

  const CategoryDetail({this.category, this.categoryId, this.merchantId});
  factory CategoryDetail.fromJson(Map<String, dynamic> json) =>
      _$CategoryDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDetailToJson(this);
  @override
  // TODO: implement props
  List<Object?> get props => [category, categoryId, merchantId];
}
