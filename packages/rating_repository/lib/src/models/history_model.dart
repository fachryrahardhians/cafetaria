import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_model.g.dart';

@JsonSerializable()
class HistoryModel extends Equatable {
  final String? orderId;
  final String? merchantId;
  final int? total;
  final String? timestamp;
  final String? statusOrder;
  final List<OrderMenu>? menus;

  const HistoryModel(
      {this.orderId,
      this.merchantId,
      this.total,
      this.timestamp,
      this.statusOrder,
      this.menus});

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);

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
      orderId: historyId ?? this.orderId,
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
  final String? menuId;
  final String? notes;
  final int? price;
  final int? qty;
  final List<OrderTopping>? toppings;

  const OrderMenu(
      {this.menuId, this.qty, this.price, this.toppings, this.notes});

  factory OrderMenu.fromJson(Map<String, dynamic> json) =>
      _$OrderMenuFromJson(json);

  Map<String, dynamic> toJson() => _$OrderMenuToJson(this);

  OrderMenu copyWith(
      {String? menuId,
      String? notes,
      int? price,
      int? qty,
      List<OrderTopping>? toppings}) {
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
  final List<ToppingItem>? items;

  const OrderTopping({this.items});

  factory OrderTopping.fromJson(Map<String, dynamic> json) =>
      _$OrderToppingFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToppingToJson(this);

  OrderTopping copyWith({List<ToppingItem>? toppings}) {
    return OrderTopping(
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [items];
}

@JsonSerializable()
class ToppingItem extends Equatable {
  final String? name;
  final int? price;

  const ToppingItem({this.name, this.price});

  factory ToppingItem.fromJson(Map<String, dynamic> json) =>
      _$ToppingItemFromJson(json);

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
