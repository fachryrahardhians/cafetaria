import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_model.g.dart';

@JsonSerializable()
class MenuModel extends Equatable {
  final String? menuId;
  final String? merchantId;
  final String? nama;

  const MenuModel({
    this.menuId,
    this.merchantId,
    this.nama,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenuModelToJson(this);

  /// Copy with a new [MenuModel].
  MenuModel copyWith({
    String? menuId,
    String? merchantId,
    String? nama,
  }) {
    return MenuModel(
      menuId: menuId ?? this.menuId,
      merchantId: merchantId ?? this.merchantId,
      nama: nama ?? this.nama,
    );
  }

  @override
  List<Object?> get props => [menuId, merchantId, nama];
}
