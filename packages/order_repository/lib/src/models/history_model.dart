import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:order_repository/src/models/merchant.dart';
import 'package:order_repository/src/models/toppingItem.dart';

part 'history_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HistoryModel extends Equatable {
  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);

  final String? orderId;

  final String? deviceToken;
  final bool? isCutlery;
  final bool? isPreorder;
  final String? pickupDate;
  final String? typePickup;
  final String? merchantId;
  final String? userId;
  final String? ratingId;
  final int? total;
  final String? keterangan;
  final String? timestamp;
  final String? statusOrder;
  final List<OrderMenu>? menus;
  final MerchantModelHistory? merchantDetail;

  const HistoryModel(
      {this.orderId,
      this.deviceToken,
      this.isCutlery,
      this.isPreorder,
      this.pickupDate,
      this.keterangan,
      this.typePickup,
      this.userId,
      this.ratingId,
      this.merchantId,
      this.total,
      this.timestamp,
      this.statusOrder,
      this.merchantDetail,
      this.menus});

  /// Copy with a new [HistoryModel].
  HistoryModel copyWith({
    String? orderId,
    String? deviceToken,
    bool? isCutlery,
    bool? isPreorder,
    String? pickupDate,
    String? typePickup,
    String? userId,
    String? merchantId,
    String? keterangan,
    String? ratingId,
    int? total,
    String? timestamp,
    String? statusOrder,
    List<OrderMenu>? menus,
    MerchantModelHistory? merchantDetail,
  }) {
    return HistoryModel(
        orderId: orderId ?? this.orderId,
        merchantId: merchantId ?? this.merchantId,
        ratingId: ratingId ?? this.ratingId,
        total: total ?? this.total,
        timestamp: timestamp ?? this.timestamp,
        statusOrder: statusOrder ?? this.statusOrder,
        menus: menus ?? this.menus,
        deviceToken: deviceToken ?? this.deviceToken,
        keterangan: keterangan ?? this.keterangan,
        isCutlery: isCutlery ?? this.isCutlery,
        isPreorder: isPreorder ?? this.isPreorder,
        pickupDate: pickupDate ?? this.pickupDate,
        typePickup: typePickup ?? this.typePickup,
        merchantDetail: merchantDetail ?? this.merchantDetail,
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
        deviceToken,
        isCutlery,
        isPreorder,
        pickupDate,
        typePickup,
        userId,
        keterangan,
        ratingId,
      ];
}

@JsonSerializable(explicitToJson: true)
class OrderMenu extends Equatable {
  final String? menuId;
  final String? notes;
  final String? name;
  final int? price;
  final int? qty;
  final List<OrderTopping>? toppings;

  const OrderMenu(
      {this.menuId,
      this.qty,
      this.price,
      this.toppings,
      this.notes,
      this.name});

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
      name: name ?? this.name,
      qty: qty ?? this.qty,
      toppings: toppings ?? this.toppings,
    );
  }

  @override
  List<Object?> get props => [menuId, notes, price, qty, toppings, name];
}

@JsonSerializable(explicitToJson: true)
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
