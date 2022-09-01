import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rule_preorder_model.g.dart';

@JsonSerializable()
class RulePreorderModel extends Equatable {
  final bool? isShowPublic;
  final String? merchantId;
  final String? pickupTime;
  final int? maxQty;
  final String? rulepreordermenuId;
  final int? poDay;

  const RulePreorderModel(
      {this.isShowPublic,
        this.merchantId,
        this.pickupTime,
        this.maxQty,
        this.poDay,
        this.rulepreordermenuId});

  factory RulePreorderModel.fromJson(Map<String, dynamic> json) =>
      _$RulePreorderModelFromJson(json);

  Map<String, dynamic> toJson() => _$RulePreorderModelToJson(this);

  @override
  List<Object?> get props => [isShowPublic, merchantId, pickupTime, maxQty, poDay, rulepreordermenuId];
}
