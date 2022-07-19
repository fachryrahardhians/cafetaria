import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'discount_model.g.dart';

@JsonSerializable()
class DiscountModel extends Equatable {
  const DiscountModel({
    required this.discount,
    required this.discountId,
    required this.menuId,
    required this.merchantId,
    required this.type,
  });

  final int discount;
  final String discountId;
  final String menuId;
  final String merchantId;
  final String type;

  //js onSerialize()
  factory DiscountModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountModelFromJson(json);
  //js onDeserialize()
  Map<String, dynamic> toJson() => _$DiscountModelToJson(this);

  @override
  List<Object?> get props => [discount, discountId, menuId, merchantId, type];

  DiscountModel copyWith({
    int? discount,
    String? discountId,
    String? menuId,
    String? merchantId,
    String? type,
  }) {
    return DiscountModel(
      discount: discount ?? this.discount,
      discountId: discountId ?? this.discountId,
      menuId: menuId ?? this.menuId,
      merchantId: merchantId ?? this.merchantId,
      type: type ?? this.type,
    );
  }
}
