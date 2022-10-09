import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'toppingItem.g.dart';
@JsonSerializable()
class ToppingItem extends Equatable {
  const ToppingItem({this.name, this.price});
  factory ToppingItem.fromJson(Map<String, dynamic> json) =>
      _$ToppingItemFromJson(json);
  final String? name;
  final int? price;

  Map<String, dynamic> toJson() => _$ToppingItemToJson(this);

  ToppingItem copyWith({String? name, int? price}) {
    return ToppingItem(
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [name, price];
}