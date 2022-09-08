// ignore_for_file: public_member_api_docs, avoid_unused_constructor_parameters, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'option_menu_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OptionMenuModel extends Equatable {
  const OptionMenuModel({
    this.isMandatory,
    this.isMultipleTopping,
    this.menuId,
    this.option,
    this.optionmenuId,
    this.title,
  });

  factory OptionMenuModel.fromJson(Map<String, dynamic> json) =>
      _$OptionMenuModelFromJson(json);

  Map<String, dynamic> toJson() => _$OptionMenuModelToJson(this);

  final bool? isMandatory;
  final bool? isMultipleTopping;
  final String? menuId;
  final List<Option>? option;
  final String? optionmenuId;
  final String? title;

  /// Copy with a new [OptionMenuModel].
  OptionMenuModel copyWith({
    bool? isMandatory,
    bool? isMultipleTopping,
    String? menuId,
    List<Option>? option,
    String? optionmenuId,
    String? title,
  }) {
    return OptionMenuModel(
      isMandatory: isMandatory ?? this.isMandatory,
      isMultipleTopping: isMultipleTopping ?? this.isMultipleTopping,
      menuId: menuId ?? this.menuId,
      option: option ?? this.option,
      optionmenuId: optionmenuId ?? this.optionmenuId,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [
        isMandatory,
        isMultipleTopping,
        menuId,
        option,
        optionmenuId,
        title,
      ];
}

@JsonSerializable()
class Option extends Equatable {
  const Option({
    this.name,
    this.price,
  });

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);

  final String? name;
  final int? price;

  Option copyWith({
    String? name,
    int? price,
  }) {
    return Option(
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [name, price];
}
