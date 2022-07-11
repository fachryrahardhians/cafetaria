// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_model.g.dart';

@JsonSerializable()
class HistoryModel extends Equatable {
  const HistoryModel({
    this.orderId,
    this.merchantId,
    this.total,
    this.timestamp,
    this.statusOrder,
    this.menus,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);

  final String? orderId;
  final String? merchantId;
  final int? total;
  final String? timestamp;
  final String? statusOrder;
  final List<OrderMenu>? menus;

  /// Copy with a new [HistoryModel].
  HistoryModel copyWith({
    String? historyId,
    String? merchantId,
    int? total,
    String? timestamp,
    String? statusOrder,
    List<OrderMenu>? menus,
  }) {
    return HistoryModel(
      orderId: historyId ?? orderId,
      merchantId: merchantId ?? this.merchantId,
      total: total ?? this.total,
      timestamp: timestamp ?? this.timestamp,
      statusOrder: statusOrder ?? this.statusOrder,
      menus: menus ?? this.menus,
    );
  }

  @override
  List<Object?> get props =>
      [orderId, merchantId, total, timestamp, statusOrder, menus];
}

@JsonSerializable()
class OrderMenu extends Equatable {
  const OrderMenu({
    this.menuId,
    this.qty,
    this.price,
    this.toppings,
    this.notes,
  });

  factory OrderMenu.fromJson(Map<String, dynamic> json) =>
      _$OrderMenuFromJson(json);

  Map<String, dynamic> toJson() => _$OrderMenuToJson(this);

  final String? menuId;
  final String? notes;
  final int? price;
  final int? qty;
  final List<OrderTopping>? toppings;

  OrderMenu copyWith({
    String? menuId,
    String? notes,
    int? price,
    int? qty,
    List<OrderTopping>? toppings,
  }) {
    return OrderMenu(
      menuId: menuId ?? this.menuId,
      notes: notes ?? this.notes,
      price: price ?? this.price,
      qty: qty ?? this.qty,
      toppings: toppings ?? this.toppings,
    );
  }

  @override
  List<Object?> get props => [menuId, notes, price, qty, toppings];
}

@JsonSerializable()
class OrderTopping extends Equatable {
  const OrderTopping({this.items});
  factory OrderTopping.fromJson(Map<String, dynamic> json) =>
      _$OrderToppingFromJson(json);
  final List<ToppingItem>? items;

  Map<String, dynamic> toJson() => _$OrderToppingToJson(this);

  OrderTopping copyWith({List<ToppingItem>? toppings}) {
    return OrderTopping(
      items: items ?? items,
    );
  }

  @override
  List<Object?> get props => [items];
}

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
