// ignore_for_file: public_member_api_docs, avoid_unused_constructor_parameters, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'option_menu_model.g.dart';

@JsonSerializable()
class OptionMenuModel extends Equatable {
  final bool? autoResetStock;
  final List<Map> category;
  final String? categoryId;
  final String? desc;
  final String? image;
  final bool? isPreOrder;
  final bool? isRecomended;
  final String? menuId;
  final List<Map> merchant;
  final String? merchantId;
  final String? name;
  final List<String> options;
  final int? price;
  final String? resetTime;
  final String? resetType;
  final List<Map> rulepreorder;
  final String? rulepreordermenuId;
  final int? stock;
  final List<String> tags;

  const OptionMenuModel({
    this.autoResetStock,
    required this.category,
    this.categoryId,
    this.desc,
    this.image,
    this.isPreOrder,
    this.isRecomended,
    this.menuId,
    required this.merchant,
    this.merchantId,
    this.name,
    required this.options,
    this.price,
    this.resetTime,
    this.resetType,
    required this.rulepreorder,
    this.rulepreordermenuId,
    this.stock,
    required this.tags,
  });

  factory OptionMenuModel.fromJson(Map<String, dynamic> json) =>
      _$OptionMenuModelFromJson(json);

  Map<String, dynamic> toJson() => _$OptionMenuModelToJson(this);

  /// Copy with a new [OptionMenuModel].
  OptionMenuModel copyWith(
      {bool? autoResetStock,
      List<Map>? category,
      String? categoryId,
      String? desc,
      String? image,
      bool? isPreOrder,
      bool? isRecomended,
      String? menuId,
      List<Map>? merchant,
      String? merchantId,
      String? name,
      List<String>? options,
      int? price,
      String? resetTime,
      String? resetType,
      List<Map>? rulepreorder,
      String? rulepreordermenuId,
      int? stock,
      List<String>? tags}) {
    return OptionMenuModel(
      autoResetStock: autoResetStock ?? this.autoResetStock,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      desc: desc ?? this.desc,
      image: image ?? this.image,
      isPreOrder: isPreOrder ?? this.isPreOrder,
      isRecomended: isRecomended ?? this.isRecomended,
      menuId: menuId ?? this.menuId,
      merchant: merchant ?? this.merchant,
      merchantId: merchantId ?? this.merchantId,
      name: name ?? this.name,
      options: options ?? this.options,
      price: price ?? this.price,
      resetTime: resetTime ?? this.resetTime,
      resetType: resetType ?? this.resetType,
      rulepreorder: rulepreorder ?? this.rulepreorder,
      rulepreordermenuId: rulepreordermenuId ?? this.rulepreordermenuId,
      stock: stock ?? this.stock,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [
        autoResetStock,
        category,
        categoryId,
        desc,
        image,
        isPreOrder,
        isRecomended,
        menuId,
        merchant,
        merchantId,
        name,
        options,
        price,
        resetTime,
        resetType,
        rulepreorder,
        rulepreordermenuId,
        stock,
        tags,
      ];
}
