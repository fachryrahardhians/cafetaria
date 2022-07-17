import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_model.g.dart';

@JsonSerializable()
class MenuModel extends Equatable {
  final String? menuId;
  final String? merchantId;
  final String? name;
  final bool? autoResetStock;
  final String? categoryId;
  final String? desc;
  final String? image;
  final bool? isPreOrder;
  final bool? isRecomended;
  final int? price;
  final String? resetTime;
  final String? resetType;
  final String? rulepreordermenuId;
  final int? stock;
  final List<String>? tags;

  const MenuModel(
      {this.menuId,
      this.merchantId,
      this.name,
      this.autoResetStock,
      this.categoryId,
      this.desc,
      this.image,
      this.isPreOrder,
      this.isRecomended,
      this.price,
      this.resetTime,
      this.resetType,
      this.rulepreordermenuId,
      this.stock,
      this.tags});

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenuModelToJson(this);

  /// Copy with a new [MenuModel].
  MenuModel copyWith(
      {String? menuId,
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
      List<String>? tags}) {
    return MenuModel(
        menuId: menuId ?? this.menuId,
        merchantId: merchantId ?? this.merchantId,
        name: name ?? this.name,
        autoResetStock: autoResetStock ?? this.autoResetStock,
        categoryId: categoryId ?? this.categoryId,
        desc: desc ?? this.desc,
        image: image ?? this.image,
        isPreOrder: isPreOrder ?? this.isPreOrder,
        isRecomended: isRecomended ?? this.isRecomended,
        price: price ?? this.price,
        resetTime: resetTime ?? this.resetTime,
        resetType: resetType ?? this.resetType,
        rulepreordermenuId: rulepreordermenuId ?? this.rulepreordermenuId,
        stock: stock ?? this.stock,
        tags: tags ?? this.tags);
  }

  @override
  List<Object?> get props => [menuId, merchantId, name];
}
