import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:option_menu_repository/src/models/option.dart';

part 'option_menu_model.g.dart';

/// OptionMenuModel
@JsonSerializable(explicitToJson: true)
class OptionMenuModel extends Equatable {
  /// OptionMenuModel
  const OptionMenuModel({
    required this.isMandatory,
    required this.isMultipleTopping,
    this.menuId,
    required this.optionmenuId,
    required this.title,
    required this.option,
  });

  /// from json
  factory OptionMenuModel.fromJson(Map<String, dynamic> json) =>
      _$OptionMenuModelFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$OptionMenuModelToJson(this);

  /// isMandatory
  final bool isMandatory;

  /// isMultipleTopping
  final bool isMultipleTopping;

  /// menuId
  final String? menuId;

  /// optionmenuId
  final String optionmenuId;

  /// title
  final String title;

  /// option
  final List<Option> option;

  @override
  List<Object?> get props => [
        isMandatory,
        isMultipleTopping,
        menuId,
        optionmenuId,
        title,
        option,
      ];

  /// copyWith - [OptionMenuModel]
  OptionMenuModel copyWith({
    bool? isMandatory,
    bool? isMultipleTopping,
    String? menuId,
    String? optionmenuId,
    String? title,
    List<Option>? option,
  }) {
    return OptionMenuModel(
      isMandatory: isMandatory ?? this.isMandatory,
      isMultipleTopping: isMultipleTopping ?? this.isMultipleTopping,
      menuId: menuId ?? this.menuId,
      optionmenuId: optionmenuId ?? this.optionmenuId,
      title: title ?? this.title,
      option: option ?? this.option,
    );
  }
}
