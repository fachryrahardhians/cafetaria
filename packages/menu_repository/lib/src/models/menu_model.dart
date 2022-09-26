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
  final int? price;
  final String? resetTime;
  final String? resetType;
  final String? rulepreordermenuId;
  final List<OpsiMenu>? options;
  final int? stock;
  final List<String>? tags;

  const MenuModel(
      {this.menuId,
      this.options,
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
      this.stock,
      this.tags});

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenuModelToJson(this);

  /// Copy with a new [MenuModel].
  MenuModel copyWith(
      {String? menuId,
      String? merchantId,
      int? defaultStock,
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
      List<OpsiMenu>? options,
      List<String>? tags}) {
    return MenuModel(
      menuId: menuId ?? this.menuId,
      merchantId: merchantId ?? this.merchantId,
      name: name ?? this.name,
      options: options ?? this.options,
      autoResetStock: autoResetStock ?? this.autoResetStock,
      defaultStock: defaultStock ?? this.defaultStock,
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
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [
        menuId,
        defaultStock,
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
        options,
        tags
      ];
}

@JsonSerializable()
class OpsiMenu extends Equatable {
  final bool? isMandatory;
  final bool? isMultipleTopping;
  final String? menuId;
  final List<Options>? option;
  final String? optionmenuId;
  final String? title;

  const OpsiMenu({
    this.isMandatory,
    this.isMultipleTopping,
    this.menuId,
    this.option,
    this.optionmenuId,
    this.title,
  });
  factory OpsiMenu.fromJson(Map<String, dynamic> json) =>
      _$OpsiMenuFromJson(json);

  Map<String, dynamic> toJson() => _$OpsiMenuToJson(this);
  OpsiMenu copyWith(
      {bool? isMandatory,
      bool? isMultipleTopping,
      String? menuId,
      List<Options>? option,
      String? optionmenuId,
      String? title}) {
    return OpsiMenu(
        isMandatory: isMandatory ?? this.isMandatory,
        isMultipleTopping: isMultipleTopping ?? this.isMultipleTopping,
        menuId: menuId ?? this.menuId,
        option: option ?? this.option,
        optionmenuId: optionmenuId ?? this.optionmenuId,
        title: title ?? this.title);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [isMandatory, isMultipleTopping, menuId, option, optionmenuId, title];
}

@JsonSerializable()
class Options extends Equatable {
  final String? name;
  final int? price;

  const Options({this.name, this.price});
  Options copyWith({String? name, int? price}) {
    return Options(name: name ?? this.name, price: price ?? this.price);
  }

  factory Options.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);
  @override
  // TODO: implement props
  List<Object?> get props => [name, price];
}
