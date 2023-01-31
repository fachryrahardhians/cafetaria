import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:menu_repository/menu_repository.dart';

part 'menu_category.g.dart';

@JsonSerializable(explicitToJson: true)
class MenuCategory extends Equatable {
  final String? category;

  final List<MenuModel>? menu;

  const MenuCategory({this.category, this.menu});

  factory MenuCategory.fromJson(Map<String, dynamic> json) =>
      _$MenuCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$MenuCategoryToJson(this);

  /// Copy with a new [MenuCategory].
  MenuCategory copyWith(
      {String? category,
      //List<OpsiMenu>? options,
      List<MenuModel>? menu}) {
    return MenuCategory(
      category: category ?? this.category,
      menu: menu ?? this.menu,
    );
  }

  @override
  List<Object?> get props => [
        category,
        menu,
      ];
}
