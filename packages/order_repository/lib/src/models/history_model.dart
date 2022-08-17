import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_model.g.dart';

@JsonSerializable()
class HistoryModel extends Equatable {
  final String? orderId;
  final int? cash;
  final String? change;
  final String? deviceToken;
  final bool? isCutlery;
  final bool? isPreorder;
  final String? pickupDate;
  final String? typePickup;
  final String? merchantId;
  final String? userId;
  final int? total;
  final String? timestamp;
  final String? statusOrder;
  final List<dynamic>? menus;

  const HistoryModel(
      {this.orderId,
      this.cash,
      this.change,
      this.deviceToken,
      this.isCutlery,
      this.isPreorder,
      this.pickupDate,
      this.typePickup,
      this.userId,
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
    String? orderId,
    int? cash,
    String? change,
    String? deviceToken,
    bool? isCutlery,
    bool? isPreorder,
    String? pickupDate,
    String? typePickup,
    String? userId,
    String? merchantId,
    int? total,
    String? timestamp,
    String? statusOrder,
    List<dynamic>? menus,
  }) {
    return HistoryModel(
        orderId: orderId ?? this.orderId,
        merchantId: merchantId ?? this.merchantId,
        total: total ?? this.total,
        timestamp: timestamp ?? this.timestamp,
        statusOrder: statusOrder ?? this.statusOrder,
        menus: menus ?? this.menus,
        cash: cash ?? this.cash,
        change: change ?? this.change,
        deviceToken: deviceToken ?? this.deviceToken,
        isCutlery: isCutlery ?? this.isCutlery,
        isPreorder: isPreorder ?? this.isPreorder,
        pickupDate: pickupDate ?? this.pickupDate,
        typePickup: typePickup ?? this.typePickup,
        userId: userId ?? this.userId);
  }

  @override
  List<Object?> get props => [
        orderId,
        merchantId,
        total,
        timestamp,
        statusOrder,
        menus,
        cash,
        change,
        deviceToken,
        isCutlery,
        isPreorder,
        pickupDate,
        typePickup,
        userId
      ];
}

@JsonSerializable()
class OrderMenu extends Equatable {
  final String? menuId;
  final String? notes;
  final String? name;
  final int? price;
  final int? qty;
  final List<OrderTopping>? toppings;

  const OrderMenu(
      {this.menuId, this.qty, this.price, this.toppings, this.notes, this.name});

  factory OrderMenu.fromJson(Map<String, dynamic> json) =>
      _$OrderMenuFromJson(json);

  Map<String, dynamic> toJson() {
    return _$OrderMenuToJson(this);
  }

  OrderMenu copyWith(
      {String? menuId,
      String? notes,
        String? name,
      int? price,
      int? qty,
      List<OrderTopping>? toppings}) {
    return OrderMenu(
      menuId: menuId ?? this.menuId,
      notes: notes ?? this.notes,
      price: price ?? this.price,
      name: name?? this.name,
      qty: qty ?? this.qty,
      toppings: toppings ?? this.toppings,
    );
  }

  @override
  List<Object?> get props => [menuId, notes, price, qty, toppings, name];
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
